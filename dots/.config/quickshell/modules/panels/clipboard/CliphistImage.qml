import QtQuick
import Quickshell.Widgets
import Quickshell.Io
import qs.modules.theme

ClippingRectangle {
    id: root

    property bool isImage
    property string rawEntry: ""
    property string entryId: ""
    property string cachedPath: "/tmp/quickshell/cliphist/" + entryId + ".png"
    property string imageSource: ""

    readonly property real aspectRatio: {
        (image.implicitHeight > 0) ? (image.implicitWidth / image.implicitHeight) : (16 / 9)
    }

    implicitHeight: Math.round(100 * Variables.scaleFactor)
    implicitWidth: Math.round(implicitHeight * aspectRatio)
    color: "white"
    radius: Variables.radiusNormal

    Binding {
        target: root.parent?.parent ?? null
        property: "width"
        value: root.implicitWidth
    }

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

