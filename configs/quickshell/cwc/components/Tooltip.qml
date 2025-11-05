import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "root:/utils"

ToolTip {
  id: tooltip
  text: modelData.name
  font.family: Appearance.data.font.family.regular
  font.pointSize: Appearance.data.font.size.xm
  delay: 1000

  contentItem: Text {
    text: tooltip.text
    font: tooltip.font
    color: "white"
  }

  background: Rectangle {
    color: "#50000000"
    radius: Appearance.data.rounding.small
  }
}
