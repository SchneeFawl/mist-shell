pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string cliphistBinary: "cliphist"
    property list<string> entries: []

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

    function refresh() {}

    function copy(id) {}

    function deleteEntry(id) {}

    function wipe() {}

    Process {
        id: readProc

        command: [root.cliphistBinary, "list"]
        
    }
}
