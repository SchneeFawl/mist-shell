import QtQuick
import Quickshell.Widgets
import Quickshell.Io
import qs.modules.theme

ClippingRectangle {
    id: root

    property string rawEntry: ""
    property string entryId: ""
    property string cachedPath: "/tmp/quickshell/cliphist/" + entryId + ".png"
    property string imageSource: ""

    property int fixedHeight: Math.round(120 * Variables.scaleFactor)
    property int fixedWidth: Math.round(230 * Variables.scaleFactor)

    // anchors.fill: parent
    implicitWidth: image.sourceSize.width
    implicitHeight: image.sourceSize.height
    color: "transparent"
    // radius: Variables.radiusNormal

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
        visible: root.imageSource !== ""
        asynchronous: true
        source: root.imageSource
        fillMode: Image.PreserveAspectFit
        retainWhileLoading: true
        sourceSize: Qt.size(root.fixedWidth, root.fixedHeight)
    }
}

