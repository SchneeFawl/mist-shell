import QtQuick
import qs.modules.theme

Rectangle {
    id: btButtonRoot

    property string icon: ""
    property bool rotationAnim: false
    signal clicked()

    height: 36
    width: 36
    color: backMouseArea.pressed ? Colors.surface_container_highest : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: backMouseArea.pressed ? 0.85 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Behavior on color  {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Text {
        id: iconText
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 20
        color: Colors.on_surface
        text: btButtonRoot.icon

        NumberAnimation on rotation {
            id: refreshRotation
            running: false
            from: 0
            to: 360
            duration: 1500
        }
    }

    MouseArea {
        id: backMouseArea
        anchors.fill: parent
        onClicked: {
            btButtonRoot.clicked();
            if (btButtonRoot.rotationAnim) {
                refreshRotation.start()
                btButtonRoot.rotationAnim = !btButtonRoot.rotationAnim
            }
        }
    }
}
