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

    implicitWidth: Math.round(200 * Variables.scaleFactor)
    implicitHeight: Math.round(100 * Variables.scaleFactor)
    color: "transparent"
    radius: Variables.radiusNormal
    clip: true

    Component.onCompleted: checkPath.running = true

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
        asynchronous: true
        source: root.imageSource
        fillMode: Image.PreserveAspectFit
        retainWhileLoading: true
        sourceSize: Qt.size(Math.round(200 * Variables.scaleFactor), Math.round(100 * Variables.scaleFactor))
    }
}

