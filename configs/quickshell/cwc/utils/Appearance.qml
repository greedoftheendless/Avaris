pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  readonly property var data: JSON.parse(fileView.text())

  function getColor(color, alpha = 1) {
    if (alpha === true) {
      alpha = data.opacity
    }

    if (alpha === 1) {
      return data.colors[color]
    }

    return `#${alpha * 100}${data.colors[color].slice(1)}`
  }

  FileView {
    id: fileView
    path: `${Paths.root}/appearance.json`
    blockLoading: true
    watchChanges: true
    onFileChanged: reload()
  }
}
