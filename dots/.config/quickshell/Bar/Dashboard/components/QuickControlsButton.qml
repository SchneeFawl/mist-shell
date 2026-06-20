import QtQuick
import qs.modules.theme

Rectangle {
    id: controlsButtonRoot

    property string icon: ""
    property int iconSize: 28

    property bool active: false
    signal clicked()

    radius: Variables.dashColumnRadius
    color: active ? Colors.primary : Colors.surface_container_high
    clip: true

    Text {
        anchors.centerIn: parent
        color: controlsButtonRoot.active ? Colors.on_primary : Colors.on_surface
        font.pixelSize: controlsButtonRoot.iconSize
        text: controlsButtonRoot.icon

        Behavior on color {
            ColorAnimation {
                duration: 360
                easing.type: Easing.OutCubic
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: controlsButtonRoot.clicked()
    }
}