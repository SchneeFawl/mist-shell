import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.modules.theme
import qs.services

Rectangle {
    id: recordRoot

    property bool showSettings: false

    anchors.fill: parent            // w = 274
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    function formatTime(seconds) {
        const totalSeconds = Math.floor(seconds);
        const mins = Math.floor(totalSeconds / 60)
        const secs = totalSeconds % 60

        if (secs < 10) {
            return (mins < 10 ? 0 : "") + mins + ":" + 0 + secs
        } else {
            return (mins < 10 ? 0 : "") + mins + ":" + secs
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing
    }
}
