import Quickshell.Io

FileView {
  id: config
  blockLoading: true
  watchChanges: true
  onFileChanged: reload()

  readonly property var data: JSON.parse(config.text())
}
