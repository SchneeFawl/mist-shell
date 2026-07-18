import QtQuick
import qs.modules.theme

Rectangle {
    id: buttonRoot

    property string icon: ""
    property int iconSize: Variables.fontLargest
    property color btnBgColor: Colors.surface_container_low
    property bool active: false

    signal clicked()

    implicitWidth: 50
    implicitHeight: 50
    radius: Variables.dashColumnRadius
    color: active ? Colors.primary : btnBgColor
    scale: mouseArea.pressed ? 0.85 : 1.0
    clip: true

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
        text: buttonRoot.icon
        font.pixelSize: buttonRoot.iconSize
        font.family: Variables.defaultFontFamily
        color: buttonRoot.active ? Colors.on_primary : Colors.on_surface
        anchors.centerIn: parent

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
        onClicked: buttonRoot.clicked()
    }
}
