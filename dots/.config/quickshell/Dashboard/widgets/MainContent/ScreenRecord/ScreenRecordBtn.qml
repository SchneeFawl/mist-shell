import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: recBtnRoot

    property string icon: ""
    property color pressedColor: Colors.surface_container_highest
    property color unpressedColor: Colors.surface_container_high
    property color textColor1: Colors.on_surface
    property color textColor2: Colors.on_surface
    signal clicked()

    implicitHeight: 36
    implicitWidth: 36
    radius: Variables.dashInnerRadius
    color: mouseArea.pressed ? pressedColor : unpressedColor
    scale: mouseArea.pressed ? 0.85 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Text {
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 20
        color: mouseArea.pressed ? recBtnRoot.textColor2 : recBtnRoot.textColor1
        text: recBtnRoot.icon

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: recBtnRoot.clicked()
    }
}
