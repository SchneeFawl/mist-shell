import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import qs.modules.theme

ClippingRectangle {
    id: root

    property string rawEntry: ""
    property string entryId: ""
    property string cachedPath: "/tmp/quickshell/cliphist/" + entryId + ".png"
    property string imageSource: ""

    Layout.preferredWidth: Math.round(200 * Variables.scaleFactor)
    Layout.preferredHeight: Math.round(100 * Variables.scaleFactor)
    color: "transparent"
    radius: Variables.radiusNormal
    clip: true

    Component.onCompleted: {
        if (root.entryId !== "" && root.rawEntry !== "") checkPath.running = true;
    }

    onEntryIdChanged: {
        if (root.entryId !== "" && root.rawEntry !== "" && root.imageSource === "") checkPath.running = true;
    }

    Process {
        id: checkPath
        command: [
            "bash", "-c", `[ -f ${root.cachedPath} ] ||
            (mkdir -p /tmp/quickshell/cliphist && printf '%s' '${root.rawEntry}' |
            cliphist decode > '${root.cachedPath}')`
        ]
        onRunningChanged: !running ? root.imageSource = "file://" + root.cachedPath : null
    }

    Image {
        id: image
        anchors.fill: parent
        visible: root.imageSource !== ""
        asynchronous: true
        source: root.imageSource
        fillMode: Image.PreserveAspectFit
        retainWhileLoading: true
        sourceSize: Qt.size(Math.round(200 * Variables.scaleFactor), Math.round(100 * Variables.scaleFactor))
    }
}

