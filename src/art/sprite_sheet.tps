<?xml version="1.0" encoding="UTF-8"?>
<data version="1.0">
    <struct type="Settings">
        <key>fileFormatVersion</key>
        <int>4</int>
        <key>texturePackerVersion</key>
        <string>5.4.0</string>
        <key>autoSDSettings</key>
        <array>
            <struct type="AutoSDSettings">
                <key>scale</key>
                <double>1</double>
                <key>extension</key>
                <string></string>
                <key>spriteFilter</key>
                <string></string>
                <key>acceptFractionalValues</key>
                <false/>
                <key>maxTextureSize</key>
                <QSize>
                    <key>width</key>
                    <int>-1</int>
                    <key>height</key>
                    <int>-1</int>
                </QSize>
            </struct>
        </array>
        <key>allowRotation</key>
        <false/>
        <key>shapeDebug</key>
        <false/>
        <key>dpi</key>
        <uint>72</uint>
        <key>dataFormat</key>
        <string>json</string>
        <key>textureFileName</key>
        <filename></filename>
        <key>flipPVR</key>
        <false/>
        <key>pvrCompressionQuality</key>
        <enum type="SettingsBase::PvrCompressionQuality">PVR_QUALITY_NORMAL</enum>
        <key>atfCompressData</key>
        <false/>
        <key>mipMapMinSize</key>
        <uint>32768</uint>
        <key>etc1CompressionQuality</key>
        <enum type="SettingsBase::Etc1CompressionQuality">ETC1_QUALITY_LOW_PERCEPTUAL</enum>
        <key>etc2CompressionQuality</key>
        <enum type="SettingsBase::Etc2CompressionQuality">ETC2_QUALITY_LOW_PERCEPTUAL</enum>
        <key>dxtCompressionMode</key>
        <enum type="SettingsBase::DxtCompressionMode">DXT_PERCEPTUAL</enum>
        <key>jxrColorFormat</key>
        <enum type="SettingsBase::JpegXrColorMode">JXR_YUV444</enum>
        <key>jxrTrimFlexBits</key>
        <uint>0</uint>
        <key>jxrCompressionLevel</key>
        <uint>0</uint>
        <key>ditherType</key>
        <enum type="SettingsBase::DitherType">NearestNeighbour</enum>
        <key>backgroundColor</key>
        <uint>0</uint>
        <key>libGdx</key>
        <struct type="LibGDX">
            <key>filtering</key>
            <struct type="LibGDXFiltering">
                <key>x</key>
                <enum type="LibGDXFiltering::Filtering">Linear</enum>
                <key>y</key>
                <enum type="LibGDXFiltering::Filtering">Linear</enum>
            </struct>
        </struct>
        <key>shapePadding</key>
        <uint>0</uint>
        <key>jpgQuality</key>
        <uint>80</uint>
        <key>pngOptimizationLevel</key>
        <uint>0</uint>
        <key>webpQualityLevel</key>
        <uint>101</uint>
        <key>textureSubPath</key>
        <string></string>
        <key>atfFormats</key>
        <string></string>
        <key>textureFormat</key>
        <enum type="SettingsBase::TextureFormat">png</enum>
        <key>borderPadding</key>
        <uint>0</uint>
        <key>maxTextureSize</key>
        <QSize>
            <key>width</key>
            <int>2048</int>
            <key>height</key>
            <int>2048</int>
        </QSize>
        <key>fixedTextureSize</key>
        <QSize>
            <key>width</key>
            <int>-1</int>
            <key>height</key>
            <int>-1</int>
        </QSize>
        <key>algorithmSettings</key>
        <struct type="AlgorithmSettings">
            <key>algorithm</key>
            <enum type="AlgorithmSettings::AlgorithmId">MaxRects</enum>
            <key>freeSizeMode</key>
            <enum type="AlgorithmSettings::AlgorithmFreeSizeMode">Best</enum>
            <key>sizeConstraints</key>
            <enum type="AlgorithmSettings::SizeConstraints">AnySize</enum>
            <key>forceSquared</key>
            <false/>
            <key>maxRects</key>
            <struct type="AlgorithmMaxRectsSettings">
                <key>heuristic</key>
                <enum type="AlgorithmMaxRectsSettings::Heuristic">Best</enum>
            </struct>
            <key>basic</key>
            <struct type="AlgorithmBasicSettings">
                <key>sortBy</key>
                <enum type="AlgorithmBasicSettings::SortBy">Best</enum>
                <key>order</key>
                <enum type="AlgorithmBasicSettings::Order">Ascending</enum>
            </struct>
            <key>polygon</key>
            <struct type="AlgorithmPolygonSettings">
                <key>alignToGrid</key>
                <uint>1</uint>
            </struct>
        </struct>
        <key>dataFileNames</key>
        <map type="GFileNameMap">
            <key>data</key>
            <struct type="DataFile">
                <key>name</key>
                <filename>../res/sprite_sheet.json</filename>
            </struct>
        </map>
        <key>multiPack</key>
        <false/>
        <key>forceIdenticalLayout</key>
        <false/>
        <key>outputFormat</key>
        <enum type="SettingsBase::OutputFormat">RGBA8888</enum>
        <key>alphaHandling</key>
        <enum type="SettingsBase::AlphaHandling">ClearTransparentPixels</enum>
        <key>contentProtection</key>
        <struct type="ContentProtection">
            <key>key</key>
            <string></string>
        </struct>
        <key>autoAliasEnabled</key>
        <true/>
        <key>trimSpriteNames</key>
        <true/>
        <key>prependSmartFolderName</key>
        <false/>
        <key>autodetectAnimations</key>
        <true/>
        <key>globalSpriteSettings</key>
        <struct type="SpriteSettings">
            <key>scale</key>
            <double>1</double>
            <key>scaleMode</key>
            <enum type="ScaleMode">Smooth</enum>
            <key>extrude</key>
            <uint>1</uint>
            <key>trimThreshold</key>
            <uint>1</uint>
            <key>trimMargin</key>
            <uint>1</uint>
            <key>trimMode</key>
            <enum type="SpriteSettings::TrimMode">CropKeepPos</enum>
            <key>tracerTolerance</key>
            <int>200</int>
            <key>heuristicMask</key>
            <false/>
            <key>defaultPivotPoint</key>
            <point_f>0.5,0.5</point_f>
            <key>writePivotPoints</key>
            <true/>
        </struct>
        <key>individualSpriteSettings</key>
        <map type="IndividualSpriteSettingsMap">
            <key type="filename">bullet_enemy_large.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>5,5,9,9</rect>
                <key>scale9Paddings</key>
                <rect>5,5,9,9</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">bullet_player_basic.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>4,3,9,7</rect>
                <key>scale9Paddings</key>
                <rect>4,3,9,7</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">circle_white.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>4,4,8,8</rect>
                <key>scale9Paddings</key>
                <rect>4,4,8,8</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">enemy-1/idle1.png</key>
            <key type="filename">enemy-1/idle10.png</key>
            <key type="filename">enemy-1/idle2.png</key>
            <key type="filename">enemy-1/idle3.png</key>
            <key type="filename">enemy-1/idle4.png</key>
            <key type="filename">enemy-1/idle5.png</key>
            <key type="filename">enemy-1/idle6.png</key>
            <key type="filename">enemy-1/idle7.png</key>
            <key type="filename">enemy-1/idle8.png</key>
            <key type="filename">enemy-1/idle9.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>5,5,10,10</rect>
                <key>scale9Paddings</key>
                <rect>5,5,10,10</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">enemy-2/idle1.png</key>
            <key type="filename">enemy-2/idle2.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>10,13,20,25</rect>
                <key>scale9Paddings</key>
                <rect>10,13,20,25</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">enemy-2/move1.png</key>
            <key type="filename">enemy-2/move2.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>10,10,20,20</rect>
                <key>scale9Paddings</key>
                <rect>10,10,20,20</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/kamehameha_center_width_1.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>0,2,1,5</rect>
                <key>scale9Paddings</key>
                <rect>0,2,1,5</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/kamehameha_center_width_2.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>0,3,1,5</rect>
                <key>scale9Paddings</key>
                <rect>0,3,1,5</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/kamehameha_center_width_3.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>0,3,1,7</rect>
                <key>scale9Paddings</key>
                <rect>0,3,1,7</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/kamehameha_head.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>5,4,10,9</rect>
                <key>scale9Paddings</key>
                <rect>5,4,10,9</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/kamehameha_tail.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>3,3,5,7</rect>
                <key>scale9Paddings</key>
                <rect>3,3,5,7</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/level_intro.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>375,268,750,535</rect>
                <key>scale9Paddings</key>
                <rect>375,268,750,535</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">exported/square_white.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>0,0,1,1</rect>
                <key>scale9Paddings</key>
                <rect>0,0,1,1</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">intro_boss/idle.png</key>
            <key type="filename">intro_boss/walk1.png</key>
            <key type="filename">intro_boss/walk2.png</key>
            <key type="filename">intro_boss/walk3.png</key>
            <key type="filename">intro_boss/walk4.png</key>
            <key type="filename">intro_boss/walk5.png</key>
            <key type="filename">intro_boss/walk6.png</key>
            <key type="filename">intro_boss/walk7.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.52,0.9</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>75,50,150,100</rect>
                <key>scale9Paddings</key>
                <rect>75,50,150,100</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">player/attack1.png</key>
            <key type="filename">player/attack2.png</key>
            <key type="filename">player/attack3.png</key>
            <key type="filename">player/attack4.png</key>
            <key type="filename">player/attack5.png</key>
            <key type="filename">player/idle.png</key>
            <key type="filename">player/run1.png</key>
            <key type="filename">player/run2.png</key>
            <key type="filename">player/run3.png</key>
            <key type="filename">player/run4.png</key>
            <key type="filename">player/run5.png</key>
            <key type="filename">player/run6.png</key>
            <key type="filename">player/run7.png</key>
            <key type="filename">player/run8.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.829032</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>13,8,25,15</rect>
                <key>scale9Paddings</key>
                <rect>13,8,25,15</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
            <key type="filename">square_white_glow.png</key>
            <struct type="IndividualSpriteSettings">
                <key>pivotPoint</key>
                <point_f>0.5,0.5</point_f>
                <key>spriteScale</key>
                <double>1</double>
                <key>scale9Enabled</key>
                <false/>
                <key>scale9Borders</key>
                <rect>6,6,12,12</rect>
                <key>scale9Paddings</key>
                <rect>6,6,12,12</rect>
                <key>scale9FromFile</key>
                <false/>
            </struct>
        </map>
        <key>fileList</key>
        <array>
            <filename>.</filename>
        </array>
        <key>ignoreFileList</key>
        <array/>
        <key>replaceList</key>
        <array/>
        <key>ignoredWarnings</key>
        <array/>
        <key>commonDivisorX</key>
        <uint>1</uint>
        <key>commonDivisorY</key>
        <uint>1</uint>
        <key>packNormalMaps</key>
        <false/>
        <key>autodetectNormalMaps</key>
        <true/>
        <key>normalMapFilter</key>
        <string></string>
        <key>normalMapSuffix</key>
        <string></string>
        <key>normalMapSheetFileName</key>
        <filename></filename>
        <key>exporterProperties</key>
        <map type="ExporterProperties"/>
    </struct>
</data>