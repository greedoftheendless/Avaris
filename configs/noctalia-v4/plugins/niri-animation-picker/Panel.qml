import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets
import qs.Services.UI

Item {
    id: root

    property var pluginApi: null

    readonly property var geometryPlaceholder: panelContainer
    readonly property bool allowAttach: true

    property real contentPreferredWidth: 460 * Style.uiScaleRatio
    property real contentPreferredHeight: 540 * Style.uiScaleRatio

    anchors.fill: parent

    // ── State ─────────────────────────────────────────────────────────────────
    property var kdlFiles: []
    property string activeFile: ""
    property bool loading: false
    property bool writing: false
    property string pendingFile: ""
    property string statusMessage: ""
    property bool statusIsError: false
    property var _fileBuffer: []

    property string home: ""

    readonly property string resolvedAnimDir: {
        var folder = pluginApi?.pluginSettings?.animationsFolder || ""
        var resolved = folder !== "" ? folder.replace("~", home) : `${home}/.config/niri/animations`
        return resolved.replace(/\/+$/, "")
    }
    readonly property string resolvedTargetFile: {
        var target = pluginApi?.pluginSettings?.targetFile || ""
        return target !== "" ? target.replace("~", home) : `${home}/.config/niri/animations.kdl`
    }
    readonly property string folderName: resolvedAnimDir !== ""
        ? resolvedAnimDir.replace(/\/+$/, "").split("/").pop()
        : "animations"

    // Relative path from the target file's directory to the animations folder
    // e.g. target=~/.config/niri/modules/animations.kdl, animDir=~/.config/niri/animations
    // → relativePath = "../animations"
    readonly property string relativePath: {
        if (resolvedAnimDir === "" || resolvedTargetFile === "") return folderName
        var targetDir = resolvedTargetFile.split("/").slice(0, -1).join("/")
        // Will be computed properly via python in applyFile, this is just for display
        return resolvedAnimDir
    }

    // ── Processes ─────────────────────────────────────────────────────────────

    Process {
        id: resolveHome
        command: ["bash", "-c", "echo -n $HOME"]
        stdout: SplitParser {
            onRead: data => {
                root.home = data.trim()
                var targetBasename = root.resolvedTargetFile.split("/").pop()
                listFiles.command = ["bash", "-c",
                    `ls "${root.resolvedAnimDir}"/*.kdl 2>/dev/null | xargs -n1 basename 2>/dev/null | grep -v "^${targetBasename}$"`]
                listFiles.running = true

                // Read current include match any path ending with folder name and kdl
                readCurrentInclude.command = ["bash", "-c",
                    `grep -oP 'include "\\K[^"]+/${root.folderName}/[^"]+\\.kdl(?=")' "${root.resolvedTargetFile}" 2>/dev/null | head -1 | xargs -I{} basename {} 2>/dev/null || true`]
                readCurrentInclude.running = true
            }
        }
    }

    Process {
        id: listFiles
        running: false
        stdout: SplitParser {
            onRead: data => {
                var f = data.trim()
                if (f.length > 0) root._fileBuffer.push(f)
            }
        }
        onRunningChanged: { if (running) { root._fileBuffer = []; root.loading = true } }
        onExited: {
            root.kdlFiles = root._fileBuffer.slice()
            root.loading = false
        }
    }

    Process {
        id: readCurrentInclude
        running: false
        stdout: SplitParser {
            onRead: data => { var f = data.trim(); if (f.length > 0) root.activeFile = f }
        }
    }

    Process {
        id: writeInclude
        running: false
        onExited: (exitCode) => {
            root.writing = false
            if (exitCode === 0) {
                root.activeFile = root.pendingFile
                root.statusIsError = false
                root.statusMessage = pluginApi?.tr("panel.applied", { file: root.pendingFile })
                ToastService.showNotice(pluginApi?.tr("panel.animationSet", { file: root.pendingFile }))
            } else {
                root.statusIsError = true
                root.statusMessage = pluginApi?.tr("panel.writeFailed", { code: exitCode })
                ToastService.showError(pluginApi?.tr("panel.writeFailedToast"))
            }
        }
    }

    function applyFile(filename) {
        if (root.resolvedTargetFile === "" || root.writing) return
        root.pendingFile = filename
        root.writing = true
        root.statusMessage = ""

        var animDir = root.resolvedAnimDir
        var target = root.resolvedTargetFile
        var folder = root.folderName

        writeInclude.command = [
            "python3", "-c",
            "import sys, os, re\n" +
            "anim_dir = sys.argv[1]\n" +
            "target   = sys.argv[2]\n" +
            "filename = sys.argv[3]\n" +
            "folder   = sys.argv[4]\n" +
            "target_dir = os.path.dirname(os.path.abspath(target))\n" +
            "rel = os.path.relpath(anim_dir, target_dir)\n" +
            "include_line = f'include \"./{rel}/{filename}\"'\n" +
            "try:\n" +
            "    f = open(target); lines = f.readlines(); f.close()\n" +
            "except FileNotFoundError:\n" +
            "    lines = []\n" +
            // Remove lines that match any relative path ending in folder name + kdl 
            "pat = re.compile(r'^include \"[^\"]*/' + folder + r'/[^\"]+\\.kdl\"\\s*$')\n" +
            "lines = [l for l in lines if not pat.match(l.strip())]\n" +
            "if lines and not lines[-1].endswith('\\n'):\n" +
            "    lines[-1] += '\\n'\n" +
            "lines.append(include_line + '\\n')\n" +
            "f = open(target, 'w'); f.writelines(lines); f.close()",
            animDir, target, filename, folder
        ]
        writeInclude.running = true
    }

    Component.onCompleted: { resolveHome.running = true }
    onVisibleChanged: { if (visible) resolveHome.running = true }

    // ── UI ────────────────────────────────────────────────────────────────────
    Rectangle {
        id: panelContainer
        anchors.fill: parent
        color: "transparent"

        ColumnLayout {
            anchors { fill: parent; margins: Style.marginL }
            spacing: Style.marginM

            // ── Header ───────────────────────────────────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: Style.marginM

                NIcon { icon: "sparkles"; color: Color.mPrimary; pointSize: Style.fontSizeL }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2
                    NText {
                        text: pluginApi?.tr("panel.title")
                        pointSize: Style.fontSizeL; font.weight: Font.Bold; color: Color.mOnSurface
                        Layout.fillWidth: true
                    }
                    NText {
                        text: root.loading
                            ? (pluginApi?.tr("panel.scanning"))
                            : root.kdlFiles.length > 0
                                ? (pluginApi?.tr("panel.presetsAvailable", { count: root.kdlFiles.length }))
                                : (pluginApi?.tr("panel.noPresetsFound"))
                        pointSize: Style.fontSizeXS; color: Color.mOnSurfaceVariant
                    }
                }

                NIconButton {
                    icon: "x"
                    baseSize: 28
                    onClicked: pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }

            // ── Path info card ───────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: pathCol.implicitHeight + Style.marginM * 2
                color: Color.mSurfaceVariant
                radius: Style.radiusM

                ColumnLayout {
                    id: pathCol
                    anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter; margins: Style.marginM }
                    spacing: Style.marginXS

                    RowLayout {
                        spacing: Style.marginS
                        NIcon { icon: "folder-open"; color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeS }
                        NText {
                            text: root.resolvedAnimDir || "~/.config/niri/animations"
                            pointSize: Style.fontSizeXS; color: Color.mOnSurfaceVariant
                            elide: Text.ElideLeft; Layout.fillWidth: true
                        }
                    }
                    RowLayout {
                        spacing: Style.marginS
                        NIcon { icon: "file-code"; color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeS }
                        NText {
                            text: root.resolvedTargetFile || "~/.config/niri/animations.kdl"
                            pointSize: Style.fontSizeXS; color: Color.mOnSurfaceVariant
                            elide: Text.ElideLeft; Layout.fillWidth: true
                        }
                    }
                }
            }

            // ── Status bar ───────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: statusText.implicitHeight + Style.marginS * 2
                color: root.statusIsError ? Qt.rgba(1,0.2,0.2,0.15) : Qt.rgba(0.2,1,0.4,0.12)
                radius: Style.radiusS
                visible: root.statusMessage !== ""

                RowLayout {
                    anchors { fill: parent; margins: Style.marginS }
                    spacing: Style.marginS
                    NIcon {
                        icon: root.statusIsError ? "circle-x" : "circle-check"
                        color: root.statusIsError ? Qt.rgba(1,0.3,0.3,1) : Color.mPrimary
                        pointSize: Style.fontSizeS
                    }
                    NText {
                        id: statusText
                        text: root.statusMessage; pointSize: Style.fontSizeS
                        color: root.statusIsError ? Qt.rgba(1,0.3,0.3,1) : Color.mPrimary
                        wrapMode: Text.WordWrap; Layout.fillWidth: true
                    }
                }
            }

            // ── File list ────────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Qt.rgba(Color.mSurfaceVariant.r, Color.mSurfaceVariant.g, Color.mSurfaceVariant.b, 0.5)
                radius: Style.radiusL

                // Loading
                ColumnLayout {
                    anchors.centerIn: parent
                    visible: root.loading
                    spacing: Style.marginM
                    NIcon { icon: "loader"; color: Color.mPrimary; pointSize: Style.fontSizeXXL; Layout.alignment: Qt.AlignHCenter }
                    NText {
                        text: pluginApi?.tr("panel.scanningAnimations")
                        color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeM; Layout.alignment: Qt.AlignHCenter
                    }
                }

                // Empty
                ColumnLayout {
                    anchors.centerIn: parent
                    visible: !root.loading && root.kdlFiles.length === 0
                    spacing: Style.marginM
                    NIcon { icon: "folder-open"; color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeXXL; Layout.alignment: Qt.AlignHCenter }
                    NText {
                        text: pluginApi?.tr("panel.noFilesFound")
                        color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeM
                        horizontalAlignment: Text.AlignHCenter; Layout.alignment: Qt.AlignHCenter
                    }
                }

                // Files
                NListView {
                    anchors { fill: parent; margins: Style.marginS }
                    visible: !root.loading && root.kdlFiles.length > 0
                    model: root.kdlFiles
                    gradientColor: Qt.rgba(Color.mSurfaceVariant.r, Color.mSurfaceVariant.g, Color.mSurfaceVariant.b, 0.5)

                    delegate: Rectangle {
                        id: fileRow
                        width: ListView.view.width
                        height: 52 * Style.uiScaleRatio
                        property bool isActive: modelData === root.activeFile
                        property bool isHovered: false

                        color: isActive
                            ? Qt.rgba(Color.mPrimary.r, Color.mPrimary.g, Color.mPrimary.b, 0.18)
                            : isHovered ? Color.mSurface : "transparent"
                        radius: Style.radiusM
                        Behavior on color { ColorAnimation { duration: 100 } }

                        RowLayout {
                            anchors { fill: parent; leftMargin: Style.marginM; rightMargin: Style.marginM }
                            spacing: Style.marginM

                            Rectangle {
                                width: 3; height: parent.height * 0.5; radius: 2
                                color: Color.mPrimary
                                opacity: fileRow.isActive ? 1 : 0
                                Behavior on opacity { NumberAnimation { duration: 150 } }
                            }

                            NText {
                                text: modelData
                                color: fileRow.isActive ? Color.mPrimary : Color.mOnSurface
                                pointSize: Style.fontSizeM
                                font.weight: fileRow.isActive ? 600 : 400
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            NIcon {
                                icon: root.writing && root.pendingFile === modelData ? "loader" : "check"
                                color: Color.mPrimary; pointSize: Style.fontSizeM
                                opacity: fileRow.isActive || (root.writing && root.pendingFile === modelData) ? 1 : 0
                                Behavior on opacity { NumberAnimation { duration: 150 } }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: fileRow.isHovered = true
                            onExited:  fileRow.isHovered = false
                            onClicked: { if (!root.writing) root.applyFile(modelData) }
                        }
                    }
                }
            }
        }
    }
}
