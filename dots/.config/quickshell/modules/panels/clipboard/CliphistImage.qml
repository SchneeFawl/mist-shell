import QtQuick
// import Quickshell.Widgets
import Quickshell.Io
import qs.modules.theme

Rectangle {
    id: root

    property bool isImage
    property string rawEntry: ""
    property string entryId: ""
    property string cachedPath: "/tmp/quickshell/cliphist/" + entryId + ".png"
    property string imageSource: ""

    property real maxWidth: Math.round(220 * Variables.scaleFactor)
    property real maxHeight: Math.round(120 * Variables.scaleFactor)

    property int imageWidth: {
        if (!rawEntry) return 0;
        let match = rawEntry.match(/(\d+)x(\d+)/);
        return match ? parseInt(match[2]) : 0;
    }

    property int imageHeight: {
        if (!rawEntry) return 0;
        let match = rawEntry.match(/(\d+)x(\d+)/);
        return match ? parseInt(match[2]) : 0;
    }

    property real imageScale: {
        if (imageWidth <= 0 || imageHeight <= 0) return 1.0;
        return Math.min(maxWidth / imageWidth, maxHeight / imageWidth, 1.0);
    }

    implicitWidth: imageWidth > 0 ? Math.round(imageWidth * imageScale) : maxWidth
    implicitHeight: imageHeight > 0 ? Math.round(imageHeight * imageScale) : maxHeight
    color: "white"
    radius: Variables.radiusNormal

    Component.onCompleted: {
        if (root.entryId !== "" && root.rawEntry !== "") checkPath.running = true;
    }

    onEntryIdChanged: {
        if (root.entryId !== "" && root.rawEntry !== "" && root.imageSource === "") checkPath.running = true;
    }

    Process {
        id: checkPath
        command: [
            "bash", "-c", `[ -s '${root.cachedPath}' ] ||
            (mkdir -p /tmp/quickshell/cliphist &&
            cliphist decode ${root.entryId} > '${root.cachedPath}.tmp' &&
            mv '${root.cachedPath}.tmp' '${root.cachedPath}')`
        ]
        onRunningChanged: {
            if (!running && root.cachedPath !== "") {
                root.imageSource = "file://" + root.cachedPath;
            }
        }
    }

    Image {
        id: image
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        // anchors.fill: parent
        visible: root.imageSource !== ""
        asynchronous: true
        source: root.imageSource
        fillMode: Image.PreserveAspectFit
        retainWhileLoading: true
    }
}

