import QtQuick
import qs.modules.theme

// qmllint disable unqualified

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
    clip: true

    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    Text {
        text: buttonRoot.icon
        font.pixelSize: buttonRoot.iconSize
        color: buttonRoot.active ? Colors.on_primary : Colors.on_surface
        anchors.centerIn: parent

        Behavior on color {
            ColorAnimation {
                duration: 400
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: buttonRoot.clicked()
    }
}
