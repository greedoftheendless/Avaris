import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets
import qs.Services.UI

Item {
    id: root

    property var pluginApi: null

    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    readonly property var mainInstance: pluginApi?.mainInstance
    readonly property string screenName: screen?.name ?? ""
    readonly property string resolvedBarPosition: Settings.getBarPositionForScreen(screenName)
    readonly property bool isBarVertical: resolvedBarPosition === "left" || resolvedBarPosition === "right"
    readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screenName)
    readonly property real barFontSize: Style.getBarFontSizeForScreen(screenName)

    // Settings tie-ins
    readonly property real catSize: mainInstance?.catSize ?? 1.0
    readonly property real catOffsetY: mainInstance?.catOffsetY ?? 0.0
    readonly property real widthPadding: pluginApi?.pluginSettings?.widthPadding ?? 0.2

    // Orientation-aware cat sizing (both driven by the catSize slider)
    readonly property real catSizeHorizontal: catSize
    readonly property real catSizeVertical: catSize * 0.50
    readonly property real activeCatSize: isBarVertical ? catSizeVertical : catSizeHorizontal

    // Glyph map: b = left paw up, d = left paw down, c = right paw up, a = right paw down, e+f = sleep, g+h = blink
    readonly property var glyphMap: ["bc", "dc", "ba", "da"]  // [idle, leftSlap, rightSlap, bothSlap]
    readonly property string sleepGlyph: "ef"
    readonly property string blinkGlyph: "gh"

    readonly property int catState: mainInstance?.catState ?? 0
    readonly property bool paused: mainInstance?.paused ?? false
    readonly property bool waiting: mainInstance?.waiting ?? false
    readonly property string catColorKey: mainInstance?.catColor ?? "default"
    readonly property bool blinking: mainInstance?.blinking ?? false
    readonly property bool showRainbowColor: mainInstance?.showRainbowColor ?? false
    readonly property string rainbowColor: mainInstance?.currentRainbowColor ?? "#ff0000"

    function resolveColor(key) {
        switch (key) {
            case "primary":   return Color.mPrimary
            case "secondary": return Color.mSecondary
            case "tertiary":  return Color.mTertiary
            case "error":     return Color.mError
            default:          return Color.mOnSurface
        }
    }

    readonly property color resolvedCatColor: showRainbowColor ? rainbowColor : resolveColor(catColorKey)

    // Sizing: capsule dimensions drive implicit size
    readonly property real horizontalPadding: capsuleHeight * widthPadding
    readonly property real contentWidth: isBarVertical
        ? capsuleHeight
        : catText.implicitWidth + horizontalPadding + (paused ? pauseExpandAmount : 0)
    readonly property real contentHeight: isBarVertical
        ? catText.implicitHeight + horizontalPadding + (paused ? pauseExpandAmount : 0)
        : capsuleHeight

    // Pause indicator expand/slide
    readonly property real pauseIconSize: capsuleHeight * 0.45
    readonly property real pauseExpandAmount: capsuleHeight * 0.8
    readonly property real pauseSlideOffset: paused ? -pauseExpandAmount / 2 : 0

    implicitWidth: contentWidth
    implicitHeight: contentHeight

    FontLoader {
        id: bongoFont
        source: pluginApi ? pluginApi.pluginDir + "/bongocat-Regular.otf" : ""
    }

    Rectangle {
        id: visualCapsule
        x: Style.pixelAlignCenter(parent.width, width)
        y: Style.pixelAlignCenter(parent.height, height)
        width: root.contentWidth
        height: root.contentHeight
        radius: Style.radiusL

        Behavior on width {
            NumberAnimation { duration: Style.animationNormal; easing.type: Easing.OutCubic }
        }
        Behavior on height {
            NumberAnimation { duration: Style.animationNormal; easing.type: Easing.OutCubic }
        }
        color: mouseArea.containsMouse ? Color.mHover : (root.paused ? root.resolvedCatColor : Style.capsuleColor)
        border.color: Style.capsuleBorderColor
        border.width: Style.capsuleBorderWidth

        Behavior on color {
            ColorAnimation { duration: Style.animationNormal; easing.type: Easing.OutCubic }
        }

        Text {
            id: catText
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.isBarVertical ? 0 : root.pauseSlideOffset
            anchors.verticalCenterOffset: root.capsuleHeight * root.catOffsetY + (root.isBarVertical ? root.pauseSlideOffset : 0)
            font.family: bongoFont.name
            font.pixelSize: root.capsuleHeight * root.activeCatSize
            font.weight: Font.Thin
            color: mouseArea.containsMouse ? Color.mOnHover : (root.paused ? Color.mSurface : root.resolvedCatColor)
            text: (root.paused || root.waiting) ? root.sleepGlyph : (root.blinking ? root.blinkGlyph : (root.glyphMap[root.catState] ?? "bc"))

            Behavior on anchors.horizontalCenterOffset {
                NumberAnimation { duration: Style.animationNormal; easing.type: Easing.OutCubic }
            }
            Behavior on anchors.verticalCenterOffset {
                NumberAnimation { duration: Style.animationNormal; easing.type: Easing.OutCubic }
            }
        }

        NIcon {
            id: pauseIcon
            icon: "player-pause-filled"
            pointSize: root.pauseIconSize
            applyUiScale: false
            color: catText.color
            opacity: root.paused ? 1 : 0
            x: root.isBarVertical
                ? (parent.width - width) / 2
                : parent.width - (root.pauseExpandAmount + width) / 2 - root.capsuleHeight * 0.20
            y: root.isBarVertical
                ? parent.height - (root.pauseExpandAmount + height) / 2 - root.capsuleHeight * 0.10
                : (parent.height - height) / 2

            Behavior on opacity {
                NumberAnimation { duration: Style.animationFast; easing.type: Easing.OutCubic }
            }
        }

        Repeater {
            id: zzzRepeater
            property real catFontSize: catText.font.pixelSize
            property color catFontColor: catText.color
            property real catX: catText.x
            property real catY: catText.y
            property real catW: catText.width
            property bool sleeping: root.paused || root.waiting

            readonly property real baseScale: 0.28
            readonly property real scaleStep: 0.07
            readonly property real xOrigin: 0.55
            readonly property real xSpacing: 0.18
            readonly property real floatHeight: 0.7
            readonly property int staggerDelay: 500
            readonly property int floatDuration: 1800
            readonly property int fadeInDuration: 300
            readonly property int fadeOutDuration: 1500

            model: 3
            delegate: Text {
                id: zItem
                required property int index
                text: "z"
                font.pixelSize: zzzRepeater.catFontSize * (zzzRepeater.baseScale + index * zzzRepeater.scaleStep)
                font.weight: Font.Bold
                color: zzzRepeater.catFontColor
                visible: zzzRepeater.sleeping
                opacity: 0
                x: zzzRepeater.catX + zzzRepeater.catW * zzzRepeater.xOrigin + index * zzzRepeater.catFontSize * zzzRepeater.xSpacing
                y: zzzRepeater.catY

                SequentialAnimation {
                    id: zAnim
                    running: zzzRepeater.sleeping
                    loops: Animation.Infinite

                    PauseAnimation { duration: zItem.index * zzzRepeater.staggerDelay }

                    ParallelAnimation {
                        NumberAnimation {
                            target: zItem; property: "y"
                            from: zzzRepeater.catY
                            to: zzzRepeater.catY - zzzRepeater.catFontSize * zzzRepeater.floatHeight
                            duration: zzzRepeater.floatDuration
                            easing.type: Easing.OutQuad
                        }
                        SequentialAnimation {
                            NumberAnimation {
                                target: zItem; property: "opacity"
                                from: 0; to: 1
                                duration: zzzRepeater.fadeInDuration
                            }
                            NumberAnimation {
                                target: zItem; property: "opacity"
                                from: 1; to: 0
                                duration: zzzRepeater.fadeOutDuration
                                easing.type: Easing.InQuad
                            }
                        }
                    }
                }

                onVisibleChanged: {
                    if (!visible) {
                        zAnim.stop();
                        opacity = 0;
                        y = zzzRepeater.catY;
                    }
                }
            }
        }

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                PanelService.showContextMenu(contextMenu, root, screen);
            } else if (root.mainInstance) {
                root.mainInstance.paused = !root.mainInstance.paused;
            }
        }
    }

    NPopupContextMenu {
        id: contextMenu
        model: [{
            "label": I18n.tr("actions.widget-settings"),
            "action": "widget-settings",
            "icon": "settings"
        }]
        onTriggered: action => {
            contextMenu.close();
            PanelService.closeContextMenu(screen);
            if (action === "widget-settings") {
                BarService.openPluginSettings(screen, pluginApi.manifest);
            }
        }
    }
}
