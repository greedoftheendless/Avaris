pragma Singleton

import Quickshell
import Qt.labs.platform

Singleton {
  id: root

  readonly property url root: Quickshell.shellRoot
}
