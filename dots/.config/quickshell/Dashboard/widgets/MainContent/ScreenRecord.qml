import QtQuick
import QtQuick.Controls
import "./ScreenRecord"
import qs.modules.theme

Rectangle {
    id: recordRoot

    property bool showSettings: false

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    StackView {
        id: recordStack
        anchors.fill: parent
        initialItem: ScreenRecordMain {}

        pushEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: recordRoot.width
                to: 0
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
        }
        pushExit: Transition {
            NumberAnimation {
                properties: "x"
                from: 0
                to: -recordRoot.width
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
        }
        popEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: -recordRoot.width
                to: 0
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
        }
        popExit: Transition {
            NumberAnimation {
                properties: "x"
                from: 0
                to: recordRoot.width
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
        }
    }
}
