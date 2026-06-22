import QtQuick
import qs.modules.theme

Rectangle {
    id: nextMonthRoot

    signal clicked()

    implicitHeight: 28
    implicitWidth: 28
    radius: width / 2
    color: nextHover.hovered ? Colors.surface_container_highest : Colors.surface_container_high
    scale: mouseArea.pressed ? 0.9 : 1.0

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
        text: ""
        color: Colors.on_surface
        anchors.centerIn: parent
    }

    HoverHandler { id: nextHover }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: nextMonthRoot.clicked()
    }
}
