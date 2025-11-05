import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/utils"
import "root:/components"

Rectangle {
  id: item

  property int length: config.data.iconSize * pseudoScale + Appearance.data.spacing.small + (config.data.alwaysVisible ? (config.data.iconSize + Appearance.data.spacing.small) : additionalHeight)
  property int breadth: config.data.iconSize + Appearance.data.spacing.small

  width: config.data.orientation == "vertical" ? length : breadth
  height: config.data.orientation == "vertical" ? breadth : length

  color: "transparent"

  Timer {
    id: timer
  }

  function delay(height, latestIndex = row.current) {
    timer.interval = Math.abs(index - latestIndex) * Appearance.data.animation.duration.sequential
    timer.repeat = false
    timer.triggered.connect(() => additionalHeight = height)
    timer.start()
  }

  property int additionalHeight: 0
  property real pseudoScale: {
    if (row.current == -1) return 0
    else {
      const falloff = config.data.falloff || 3
      let diff = Math.abs(index - row.current)
      diff = Math.max(0, falloff - diff)
      let damp = falloff - Math.max(1, diff)
      let sc = config.data.scaleFactor
      if (damp) sc /= damp * (config.data.damp || 1)
      diff = diff / falloff * sc
      return diff
    }
  }

  MouseArea {
    id: itemMouseArea
    anchors.fill: parent
    hoverEnabled: true
    onEntered: { row.current = index; if (!config.data.alwaysVisible) { window.expand() } }
    onExited: { if (row.current == index) { row.current = -1; if (!config.data.alwaysVisible) { window.collapse(index) } } }
    onClicked: modelData.execute()
    cursorShape: Qt.PointingHandCursor
    propagateComposedEvents: true

    Tooltip {
      visible: config.data.showTooltips ? parent.containsMouse : false
    }

    Column {
      anchors.top: config.data.position == "bottom" ? parent.top : undefined
      anchors.right: config.data.position == "left" ? parent.right : undefined
      anchors.bottom: config.data.position == "top" ? parent.bottom : undefined
      anchors.left: config.data.position == "right" ? parent.left : undefined

      anchors.horizontalCenter: config.data.orientation == "horizontal" ? parent.horizontalCenter : undefined
      anchors.verticalCenter: config.data.orientation == "vertical" ? parent.verticalCenter : undefined

      topPadding: config.data.position == "bottom" ? Appearance.data.spacing.small : undefined
      rightPadding: config.data.position == "left" ? Appearance.data.spacing.small : undefined
      bottomPadding: config.data.position == "top" ? Appearance.data.spacing.small : undefined
      leftPadding: config.data.position == "right" ? Appearance.data.spacing.small : undefined

      width: config.data.orientation == "vertical" ? item.length : config.data.iconSize
      height: config.data.orientation == "vertical" ? config.data.iconSize : item.length

      Rectangle {
        width: config.data.iconSize
        height: width

        color: config.data.showIconsBackground ? Appearance.getColor("background", true) : "transparent"
        radius: Appearance.data.rounding.medium
        border.color: Appearance.getColor("primary")
        border.width: itemMouseArea.containsPress ? 1 : 0

        Image {
          width: parent.width
          height: width
          source: Quickshell.iconPath(modelData.icon)

          transform: Scale {
            origin.x: config.data.iconSize / 2
            origin.y: config.data.iconSize / 2
            xScale: itemMouseArea.containsPress ? 0.9 : 1
            yScale: itemMouseArea.containsPress ? 0.9 : 1
          }
        }
      }
    }
  }

  Behavior on length {
    NumberAnimation {
      duration: Appearance.data.animation.duration.normal
      easing.type: Easing.OutBack
    }
  }
}
