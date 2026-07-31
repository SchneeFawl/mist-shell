pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool panelVisible: false

    property string cliphistBinary: "cliphist"
    property list<string> entries: []
    property var rawBuffer: []

    function parsedLine(line) {
        let tabIdx = line.indexOf("\t");
        if (tabIdx === -1) return null;
        let idStr = line.substring(0, tabIdx);
        let contentStr = line.substring(tabIdx + 1);
        let isImg = /^\[\[.*binary data.*\d+x\d+.*\]\]$/.test(contentStr);
        return {
            id: idStr,
            text: contentStr,
            isImage: isImg,
            rawEntry: line
        }
    }

    function refresh() {
        readProc.buffer = [];
        readProc.running = true;
    }

    function copy(rawEntry) {
        Quickshell.execDetached(["bash", "-c", `printf '%s' "${rawEntry}" | ${cliphistBinary} decode | wl-copy`]);
    }

    function deleteEntry(rawEntry) {
        Quickshell.execDetached(["bash", "-c", `printf '%s' "${rawEntry}" | ${cliphistBinary} delete`]);
        refreshTimer.restart();
    }

    function wipe() {
        Quickshell.execDetached([cliphistBinary, "wipe"]);
        refreshTimer.restart();
    }

    Process {
        id: readProc

        command: [root.cliphistBinary, "list"]
        stdout: SplitParser {
            onRead: (line) => root.rawBuffer.push(line)
        }

        onRunningChanged: {
            // process finished
            if (!running) {
                let parsed = [];
                for (let i = 0; i < root.rawBuffer.length; i++) {
                    let item = root.parsedLine(root.rawBuffer[i]);
                    if (item) parsed.push(item);
                }
                root.entries = parsed;
                root.rawBuffer = [];        // reset buffer for next refresh
            }
        }
    }

    Timer {
        id: refreshTimer
        interval: 150
        repeat: false
        onTriggered: root.refresh()
    }

    Connections {
        target: Quickshell
        function onClipboardTextChanged() {
            refreshTimer.restart();
        }
    }
}
