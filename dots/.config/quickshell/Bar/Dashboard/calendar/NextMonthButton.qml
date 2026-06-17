import QtQuick
import qs.modules.theme

Rectangle {
    id: nextMonthRoot

    signal clicked()

    implicitHeight: 28
    implicitWidth: 28
    radius: width / 2
    color: nextHover.hovered ? Colors.activeVibrant : "black"

    Behavior on color {
        ColorAnimation {
            easing.type: Easing.OutCubic
            duration: 180
        }
    }

    Text {
        text: ""
        color: "white"
        anchors.centerIn: parent
    }

    HoverHandler { id: nextHover }

    MouseArea {
        anchors.fill: parent
        onClicked: nextMonthRoot.clicked()
    }
}
