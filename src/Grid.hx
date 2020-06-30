import hxd.Key;
import TestUtils.assert;
import Fonts;
import SaveState;
using StringTools;

typedef GridKey = String;
typedef GridItems = Map<GridKey, GridKey>;

typedef GridRef = {
  var cellSize: Int;
  var data: Map<
    Int, // row-index
    Map< // row-data
      Int, // column-index
      GridItems
    >
  >;
  var itemCache: Map<GridKey, Array<Int>>;
  var type: String;
  var pruneEmptyCell: Bool;
}

enum GridEditMode {
  Normal;
  Insert;
  Delete;
}

class GridEditor {
  var isReady = false;
  var mouseGridRef: GridRef;
  var environmentGridRef: GridRef;
  var canvas: h2d.Graphics;
  var text: h2d.Text;
  var cellTile: h2d.Tile;
  var cellSize = 64;
  var texture: h3d.mat.Texture;
  var cursorSize: Int;
  var debugPoint: h2d.Graphics;
  var scene: h2d.Scene;
  var editMode = GridEditMode.Normal;
  var updateGrids: (ev: {relX: Float, relY: Float}) -> Void;
  var environmentGridSavePath = 'test.map';
  var cds = new Game.Cooldown();
  var hasPendingSave = false;
  var objectsToCleanup: Array<Dynamic> = [];
  var handleEvents: (e: hxd.Event) -> Void;

  public function new(s2d: h2d.Scene) {
    scene = s2d;

    {
      var originPoint = new h2d.Graphics(s2d);
      objectsToCleanup.push(originPoint);
      originPoint.beginFill(0xffffff, 0);
      originPoint.lineStyle(2, 0xffffff);
      originPoint.drawCircle(0, 0, 4);
    }
    {
      debugPoint = new h2d.Graphics(s2d);
      objectsToCleanup.push(debugPoint);
      debugPoint.beginFill(Game.Colors.yellow);
      debugPoint.drawCircle(0, 0, 10);
    }
    cursorSize = cellSize;
    texture = new h3d.mat.Texture(s2d.width, s2d.height, [h3d.mat.Data.TextureFlags.Target]);
    var tile = h2d.Tile.fromTexture(texture);

    cellTile = tile.sub(0, 0, cellSize, cellSize);
    canvas = new h2d.Graphics(s2d);
    objectsToCleanup.push(canvas);
    canvas.beginFill(0xffffff, 0);
    canvas.lineStyle(1, 0xffffff);
    canvas.drawRect(0, 0, cellSize, cellSize);
    canvas.drawTo(texture);

    var cellFont = Fonts.primary.get().clone();
    cellFont.resizeTo(Math.round(12 * 1.5));
    text = new h2d.Text(cellFont, s2d);
    objectsToCleanup.push(text);
    var textCanvas = new h2d.Graphics(s2d);
    objectsToCleanup.push(textCanvas);
    var textTexture = new h3d.mat.Texture(
      s2d.width, s2d.height, [h3d.mat.Data.TextureFlags.Target]
    );
    var textTile = h2d.Tile.fromTexture(textTexture);

    function drawGridInfo(ref: Grid.GridRef) {
      textTexture.clear(0xffffff, 0);
      textCanvas.clear();
      var tiles = [];

      for (y => row in ref.data) {
        for (x => cellData in row) {
          text.x = x * cellSize;
          text.y = y * cellSize;

          var numKeys = 0;
          for (_ in cellData.keys()) {
            numKeys += 1;
          }
          text.text = '${numKeys}';
          text.drawTo(textTexture);
          tiles.push(
            textTile.sub(
              text.x,
              text.y,
              text.textWidth,
              text.textHeight
            )
          );
        }
      }

      textCanvas.alpha = 0.5;
      for (t in tiles) {
        textCanvas.drawTile(
          t.x + cellSize / 2 - t.width / 2,
          t.y + cellSize / 2 - t.height / 2,
          t
        );
      }
    }


    function onReady() {
      var dragState = {
        startMousePoint: {
          x: 0.0,
          y: 0.0
        },
        startObjectPosition: {
          x: 0.0,
          y: 0.0
        },
        endObjectPosition: {
          x: 0.0,
          y: 0.0
        },
        dragging: false
      };

      {
        function setEditMode(ev: hxd.Event) {
          if (dragState.dragging || ev.kind != hxd.Event.EventKind.EPush) {
            return;
          }

          if (ev.button == 0) {
            editMode = GridEditMode.Insert;
          }

          if (ev.button == 1) {
            editMode = GridEditMode.Delete;
          }
        }

        function setNormalMode(ev: hxd.Event) {
          if (ev.kind != hxd.Event.EventKind.ERelease) {
            return;
          }

          editMode = GridEditMode.Normal;
        }

        function setZoom(ev: hxd.Event) {
          if (ev.kind != hxd.Event.EventKind.EWheel) {
            return;
          }

          var zoomBy = 0.25;
          var zoomDelta = Math.round(ev.wheelDelta) * zoomBy;
          s2d.scaleX = Utils.clamp(s2d.scaleX - zoomDelta, zoomBy, 2);
          s2d.scaleY = Utils.clamp(s2d.scaleY - zoomDelta, zoomBy, 2);
        }

        Camera.follow(Main.Global.mainCamera, dragState.endObjectPosition);

        // pan the canvas adobe photoshop style
        handleEvents = (e: hxd.Event) -> {
          if (
            hxd.Key.isDown(hxd.Key.SPACE)
            && e.button == 0)
          {
            if (e.kind == hxd.Event.EventKind.EPush) {
              dragState.startMousePoint.x = e.relX;
              dragState.startMousePoint.y = e.relY;
              dragState.startObjectPosition.x = Main.Global.mainCamera.x;
              dragState.startObjectPosition.y = Main.Global.mainCamera.y;
              dragState.dragging = true;
            }
            if (
              e.kind == hxd.Event.EventKind.EMove
              && dragState.dragging
            ) {
              var dx = e.relX - dragState.startMousePoint.x;
              var dy = e.relY - dragState.startMousePoint.y;
              var startPos = dragState.startObjectPosition;
              var endPos = dragState.endObjectPosition;
              endPos.x = startPos.x - dx;
              endPos.y = startPos.y - dy;
            }
            if (e.kind == hxd.Event.EventKind.ERelease) {
              dragState.dragging = false;
            }
          }

          setEditMode(e);
          setNormalMode(e);
          setZoom(e);
        }
        Main.Global.uiRoot
          .addEventListener(handleEvents);
      }

      function editEnvironment(ev, editMode) {
        if (editMode == GridEditMode.Normal) {
          return;
        }

        var gridX = Grid.snapPosition(ev.relX, cursorSize);
        var gridY = Grid.snapPosition(ev.relY, cursorSize);

        if (gridX < 0 || gridY < 0) {
          return;
        }

        // add item
        if (editMode == GridEditMode.Insert) {
          // remove previous items
          var currentItems = Grid.getItemsInRect(
            environmentGridRef, gridX, gridY, cursorSize, cursorSize
          );
          for (itemKey in currentItems) {
            Grid.removeItem(environmentGridRef, itemKey);
          }

          // add new wall
          var wallId = Utils.uid((id) -> {
            !Grid.has(environmentGridRef, id);
          });
          Grid.setItemRect(environmentGridRef, gridX, gridY, cursorSize, cursorSize, wallId);
        }

        // remove item
        if (editMode == GridEditMode.Delete) {
          var items = Grid.getItemsInRect(environmentGridRef, gridX, gridY, cursorSize, cursorSize);
          for (key in items) {
            Grid.removeItem(environmentGridRef, key);
          }
        }

        hasPendingSave = true;
        cds.set('saveDebounce', 0.2);
      }

      function previewInsertArea(ev) {
        var gridX = Grid.snapPosition(ev.relX, cursorSize);
        var gridY = Grid.snapPosition(ev.relY, cursorSize);

        // clear old one
        mouseGridRef = Grid.create(cellSize);
        Grid.setItemRect(mouseGridRef, gridX, gridY, cursorSize, cursorSize, '@mouse');
        drawGridInfo(mouseGridRef);
      }

      updateGrids = function(ev) {
        previewInsertArea(ev);
        editEnvironment(ev, editMode);
      };
    }

    mouseGridRef = Grid.create(cellSize);
    Asset.loadMap(
      'test',
      (previousEnvironmentState) -> {
        environmentGridRef = previousEnvironmentState == null
          ? Grid.create(cellSize)
          : previousEnvironmentState;
        isReady = true;
        onReady();
      }, (e) -> {
        trace('error loading environment grid', e);
      }
    );
  }

  public function update(dt: Float) {
    if (!isReady) {
      return;
    }

    canvas.clear();
    cds.update(dt);

    updateGrids({
      relX: scene.mouseX,
      relY: scene.mouseY
    });

    if (hasPendingSave && !cds.has('saveDebounce')) {
      SaveState.save(
        environmentGridRef,
        environmentGridSavePath,
        #if jsMode
          '${Config.devServer}/save-state',
        #else
          null,
        #end
        (_) -> {
          trace('map grid saved');
        },
        (e) -> {
          trace('error saving environment grid', e);
        }
      );
      hasPendingSave = false;
    }

    {
      var gridX = Grid.snapPosition(scene.mouseX, cursorSize);
      var gridY = Grid.snapPosition(scene.mouseY, cursorSize);

      debugPoint.x = gridX;
      debugPoint.y = gridY;

      // toggle cursor size
      if (Key.isPressed(Key.T)) {
        cursorSize = cursorSize == cellSize
          ? cellSize * 2 : cellSize;
      }
    }

    // render grid
    for (gridRef in [mouseGridRef, environmentGridRef]) {
      Grid.eachCell(gridRef, (x, y, items) -> {
        if (Lambda.count(items) == 0) {
          return;
        }

        canvas.beginFill(Game.Colors.pureWhite, 0);
        canvas.lineStyle(4, Game.Colors.pureWhite);
        // offset by 0.5 since lines are drawn at the
        // center of a point which can cause issues
        // when down-scaling
        canvas.drawRect(
          x * cellTile.width,
          y * cellTile.height,
          cellTile.width,
          cellTile.height
        );
      });
    }

    {
      var mouseX = Main.Global.rootScene.mouseX;
      var mouseY = Main.Global.rootScene.mouseY;
      canvas.beginFill(Game.Colors.yellow, 0);
      canvas.lineStyle(4, Game.Colors.yellow);
      canvas.drawRect(
        // snap to grid
        mouseX - cursorSize / 2,
        mouseY - cursorSize / 2,
        cursorSize,
        cursorSize
      );
    }
  }

  public function remove() {
    for (o in objectsToCleanup) {
      o.remove();
    }
    Main.Global.rootScene.scaleX = 1;
    Main.Global.rootScene.scaleY = 1;
  }
}

class Grid {
  // snaps to the center of a cell
  public static function snapPosition(v: Dynamic, cellSize) {
    return Math.ceil(v / cellSize) * cellSize - Math.floor(cellSize / 2);
  }

  public static function create(
    cellSize,
    // automatically cleans up empty rows and cells after each item removal
    pruneEmptyCell = true
  ): GridRef {
    return {
      cellSize: cellSize,
      data: new Map(),
      itemCache: new Map(),
      pruneEmptyCell: pruneEmptyCell,
      type: 'Grid'
    }
  }

  public static function has(ref: GridRef, key: GridKey) {
    return ref.itemCache.exists(key);
  }

  public static function isEmptyCell(ref: GridRef, x, y) {
    var cellData = getCell(ref, x, y);

    if (cellData == null) {
      return true;
    }

    return Lambda.count(cellData) == 0;
  }

  inline public static function getCell(ref: GridRef, x, y) {
    var row = ref.data[y];

    return row != null ? row[x] : null;
  }

  static function addItem(ref: GridRef, x, y, key: GridKey) {
    var curRow = ref.data[y];
    ref.data[y] = curRow == null ? new Map() : curRow;
    var curCell = ref.data[y][x];
    ref.data[y][x] = curCell == null ? new Map() : curCell;
    ref.data[y][x][key] = key;
  }

  // NOTE: origin is at center of rect
  public static function setItemRect(
    ref: GridRef,
    x: Float,
    y: Float,
    w: Int,
    h: Int,
    key: GridKey
  ) {
    var fromCache = ref.itemCache[key];
    var xMin = Math.floor(Math.round(x - (w / 2)) / ref.cellSize);
    var xMax = Math.ceil(Math.round(x + (w / 2)) / ref.cellSize);
    var yMin = Math.floor(Math.round(y - (h / 2)) / ref.cellSize);
    var yMax = Math.ceil(Math.round(y + (h / 2)) / ref.cellSize);

    if (
      fromCache != null
      && xMin == fromCache[0]
      && xMax == fromCache[1]
      && yMin == fromCache[2]
      && yMax == fromCache[3]
    ) {
      return;
    }

    removeItem(ref, key);
    ref.itemCache[key] = [xMin, xMax, yMin, yMax];

    for (_y in yMin...yMax) {
      for (_x in xMin...xMax) {
        addItem(ref, _x, _y, key);
      }
    }
  }

  public static function getItemsInRect(ref: GridRef, x: Float, y: Float, w, h) {
    var xMin = Math.floor(Math.round(x - (w / 2)) / ref.cellSize);
    var xMax = Math.ceil(Math.round(x + (w / 2)) / ref.cellSize);
    var yMin = Math.floor(Math.round(y - (h / 2)) / ref.cellSize);
    var yMax = Math.ceil(Math.round(y + (h / 2)) / ref.cellSize);
    var items: GridItems = new Map();

    for (y in yMin...yMax) {
      for (x in xMin...xMax) {
        var cellData = getCell(ref, x, y);
        if (cellData != null) {
          for (it in cellData) {
            items[it] = it;
          }
        }
      }
    }

    return items;
  }

  public static function eachCell(ref: GridRef, callback) {
    for (y => row in ref.data) {
      for (x => items in row) {
        callback(x, y, items);
      }
    }
  }

  public static function removeItem(ref: GridRef, key: GridKey) {
    var cache = ref.itemCache[key];

    if (cache == null) {
      return;
    }

    var xMin = cache[0];
    var xMax = cache[1];
    var yMin = cache[2];
    var yMax = cache[3];
    var pruneEmpty = ref.pruneEmptyCell;

    for (y in yMin...yMax) {
      for (x in xMin...xMax) {
        var cellData = getCell(ref, x, y);

        if (cellData != null) {
          cellData.remove(key);
        }

        if (
          pruneEmpty &&
          Lambda.count(cellData) == 0
        ) {
          ref.data[y].remove(x);
        }
      }

      if (
        pruneEmpty &&
        Lambda.count(ref.data[y]) == 0
      ) {
        ref.data.remove(y);
      }
    }

    ref.itemCache.remove(key);
  }

  public static function tests() {
    assert('[grid] cell should have item', (hasPassed) -> {
      var ref = Grid.create(1);
      var id = Utils.uid();

      Grid.setItemRect(ref, 2, 3, 1, 1, id);
      hasPassed(
        Grid.has(ref, id) &&
          Lambda.count(Grid.getItemsInRect(ref, 2, 3, 1, 1)) == 1
      );
    });

    assert('[grid] cell should remove item', (hasPassed) -> {
      var ref = Grid.create(1);
      var id = Utils.uid();

      Grid.setItemRect(ref, 2, 3, 1, 1, id);
      Grid.removeItem(ref, id);
      hasPassed(
        !Grid.has(ref, id) &&
          Lambda.count(Grid.getItemsInRect(ref, 2, 3, 1, 1)) == 0
      );
    });

    assert('[grid] move item', (hasPassed) -> {
      var ref = Grid.create(1);
      var id = Utils.uid();

      Grid.setItemRect(ref, 2, 3, 1, 1, id);
      Grid.setItemRect(ref, 2, 4, 1, 1, id);

      hasPassed(
        Lambda.count(Grid.getItemsInRect(ref, 2, 3, 1, 1)) == 0 &&
          Lambda.count(Grid.getItemsInRect(ref, 2, 4, 1, 1)) == 1
      );
    });

    assert('[grid] add item rect exact fit', (hasPassed) -> {
      var ref = Grid.create(1);
      var width = 1;
      var height = 3;

      Grid.setItemRect(ref, 0, 1, width, height, Utils.uid());
      hasPassed(
        Lambda.count(ref.data) == height &&
         Lambda.count(ref.data[0]) == width
      );
    });

    assert('[grid] add item rect partial overlap', (hasPassed) -> {
      var cellSize = 10;
      var ref = Grid.create(cellSize);
      var width = cellSize - 1;
      var height = cellSize - 1;

      Grid.setItemRect(
        ref,
        Math.round(width / 2) + 2,
        Math.round(height / 2) + 2,
        width,
        height,
        Utils.uid()
      );

      hasPassed(
        Lambda.count(ref.data) == Math.ceil(cellSize / height) &&
         Lambda.count(ref.data[0]) == Math.ceil(cellSize / width)
      );
    });

    assert('[grid] get items in rect', (hasPassed) -> {
      var cellSize = 1;
      var ref = Grid.create(cellSize);
      var width = 2;
      var height = 2;
      var index = 0;

      for (y in 0...(height)) {
        for (x in 0...(width)) {
          Grid.setItemRect(ref, x, y, 1, 1, Utils.uid());
          index += 1;
        }
      }

      var queryX = Math.round(width / 2);
      var queryY = Math.round(height / 2);

      hasPassed(
        Lambda.count(
          Grid.getItemsInRect(ref, queryX, queryY, width, height)
        ) == 4
      );
    });
  }
}
