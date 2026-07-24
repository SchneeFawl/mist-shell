import QtQuick
import qs.modules.theme

Rectangle {
    id: calendarButton

    property string icon: ""
    signal clicked()

    implicitHeight: Math.round((Variables.buttonHeight - 12) * Variables.scaleFactor)
    implicitWidth: implicitHeight
    radius: width / 2
    color: mouseArea.pressed ? Colors.primary : Colors.surface_container_high
    scale: mouseArea.pressed ? 0.80 : 1.0

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Text {
        anchors.centerIn: parent
        color: mouseArea.pressed ? Colors.on_primary : Colors.on_surface
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.fontLarge
        text: calendarButton.icon

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
        onClicked: calendarButton.clicked()
    }
}
