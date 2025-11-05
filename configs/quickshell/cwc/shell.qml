import Quickshell

import "widgets/dock"
import "utils"

ShellRoot {
  Dock {}
  Dock {
    name: "power-menu"
    screens: [Quickshell.screens.reduce((acc, screen) => screen.x > acc.x ? screen : acc, { x: -Infinity })] // Only use the rightmost screen for the power menu
  }
}
