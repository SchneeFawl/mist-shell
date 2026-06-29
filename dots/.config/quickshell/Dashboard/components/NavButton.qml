import QtQuick
import qs.modules.theme

Rectangle {
    id: buttonRoot

    property string icon: ""
    property int iconSize: 20
    property color btnBgColor: Colors.surface_container_low
    property bool active: false

    signal clicked()

    implicitWidth: 50
    implicitHeight: 50
    radius: Variables.dashColumnRadius
    color: active ? Colors.primary : btnBgColor
    scale: mouseArea.pressed ? 0.85 : 1.0
    clip: true

    Behavior on color {
        ColorAnimation {
            duration: 240
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 120
            easing.type: Easing.OutQuad
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
                duration: 240
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: buttonRoot.clicked()
    }
}
