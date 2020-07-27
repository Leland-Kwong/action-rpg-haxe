/*
 * [ ] paint objects by placing them anywhere
 * [ ] option to snap to grid
 */

enum EditorMode {
  Panning;
  Paint;
  Erase;
}

class Editor {
  static final objectMetaByType = [
    'white_square' => {
      spriteKey: 'ui/square_tile_test',
    },
    'enemy_1' => {
      spriteKey: 'enemy-2_animation/idle-0',
    }
  ];

  static var previousButtonDown = -1;
  static var editorMode = EditorMode.Paint;
  static var isPanning = false;
  static var dragStartPos = {
    x: 0,
    y: 0
  };
  static var translate = {
    x: 0,
    y: 0
  };
  static var zoom = 2;
  static var selectedObjectType = 'white_square';

  // state to be serialized and saved
  static var editorState = {
    translate: {
      x: 0,
      y: 0
    },
    grid: Grid.create(16),
    itemTypeById: new Map<String, String>()
  };

  public static function init() {
    final cellSize = editorState.grid.cellSize;

    final insertSquare = (gridX, gridY, id, objectType) -> {
      Grid.setItemRect(
          editorState.grid,
          (gridX * cellSize) + (cellSize / 2),
          (gridY * cellSize) + (cellSize / 2),
          cellSize,
          cellSize,
          id);

      editorState.itemTypeById
        .set(id, objectType);
    };

    final removeSquare = (gridX, gridY, width, height) -> {
      final items = Grid.getItemsInRect(
          editorState.grid,
          (gridX * cellSize) + (cellSize / 2),
          (gridY * cellSize) + (cellSize / 2),
          cellSize,
          cellSize);

      for (key in items) {
        Grid.removeItem(
            editorState.grid,
            key);
      }
    };

    final handleZoom = (e: hxd.Event) -> {
      if (e.kind == hxd.Event.EventKind.EWheel) {
        zoom -= Std.int(e.wheelDelta);
      }
    }
    Main.Global.uiRoot.addEventListener(handleZoom);

    function update(dt) {
      Main.Global.logData.editor = {
        panning: isPanning,
        editorMode: Std.string(editorMode),
      };

      final Key = hxd.Key;
      final buttonDown = Main.Global.worldMouse.buttonDown;
      final mx = Main.Global.uiRoot.mouseX;
      final my = Main.Global.uiRoot.mouseY;

      isPanning = false; 

      if (Key.isDown(Key.SPACE)) {
        isPanning = true; 
      }

      if (Key.isPressed(Key.E)) {
        editorMode = EditorMode.Erase;
      }

      if (Key.isPressed(Key.B)) {
        editorMode = EditorMode.Paint;
      }

      if (previousButtonDown != buttonDown) {
        previousButtonDown = buttonDown;
        dragStartPos.x = Std.int(mx);
        dragStartPos.y = Std.int(my);
      }

      if (buttonDown == 0) {
        if (isPanning) {
          final dx = mx - dragStartPos.x;
          final dy = my - dragStartPos.y;

          editorState.translate.x = Std.int(translate.x + dx);
          editorState.translate.y = Std.int(translate.y + dy);
        } else {
          final tx = editorState.translate.x;
          final ty = editorState.translate.y;
          final gridX = Math.floor((mx - tx) / cellSize / zoom);
          final gridY = Math.floor((my - ty) / cellSize / zoom);

          switch (editorMode) {
            case EditorMode.Erase: {
              removeSquare(
                  gridX,
                  gridY,
                  cellSize,
                  cellSize);
            }

            // replaces the cell with new value
            case EditorMode.Paint: {
              removeSquare(
                  gridX,
                  gridY,
                  cellSize,
                  cellSize);

              insertSquare(
                  gridX,
                  gridY,
                  Utils.uid(),
                  selectedObjectType);
            }

            default: {}
          }
        }
      } else {
        translate.x = editorState.translate.x;
        translate.y = editorState.translate.y;
      }


      return true;
    }

    function render(time) {
      final grid = editorState.grid;
      final spriteEffect = (p) -> {
        final b: h2d.SpriteBatch.BatchElement = p.batchElement;
        b.scale = zoom;
      };
      for (itemId => bounds in grid.itemCache) {
        final width = bounds[1] - bounds[0];
        final cx = bounds[0] + width / 2;
        final height = bounds[3] - bounds[2];
        final cy = bounds[2] + height / 2;
        final itemType = editorState.itemTypeById.get(itemId);
        final objectMeta = objectMetaByType.get(itemType);

        Main.Global.uiSpriteBatch.emitSprite(
            ((cx * cellSize)) * zoom + editorState.translate.x,
            ((cy * cellSize)) * zoom + editorState.translate.y,
            // 'ui/square_tile_test',
            objectMeta.spriteKey,
            null,
            spriteEffect);
      }

      for (y => row in grid.data) {
        for (x => col in row) {
          Main.Global.uiSpriteBatch.emitSprite(
              ((x * cellSize) + (cellSize / 2)) * zoom + editorState.translate.x,
              ((y * cellSize) + (cellSize / 2)) * zoom + editorState.translate.y,
              'ui/square_tile_test',
              // 'enemy-2_animation/idle-0',
              null,
              (p) -> {
                p.sortOrder = -9999999;
                p.batchElement.alpha = 0.2;
                spriteEffect(p);
              });
        }
      }

      return true;
    }

    Main.Global.updateHooks.push(update);
    Main.Global.renderHooks.push(render);
  }
}
