import QtQuick
import qs.modules.theme
import qs.services

Rectangle {
    id: audioTrack

    readonly property bool active: ScreenRecordService.recordAudio

    color: active ? Colors.surface_container_highest : Colors.surface_container_high
    radius: Variables.dashInnerRadius + 4
    clip: true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: ScreenRecordService.recordAudio = !ScreenRecordService.recordAudio
    }

    Rectangle {
        id: audioThumb
        property int margin: 4

        anchors.verticalCenter: parent.verticalCenter
        height: audioTrack.height - (margin * 2)
        width: audioTrack.width / 2 - 2
        radius: audioTrack.radius - margin
        color: audioTrack.active ? Colors.primary : Colors.tertiary
        x: audioTrack.active ? audioTrack.width - margin - width : margin

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationSlow
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: Variables.durationSlow
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }
}
