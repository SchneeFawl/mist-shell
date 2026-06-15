import QtQuick
import qs.modules.theme

Rectangle {
    id: prevMonthRoot

    signal clicked()

    implicitHeight: 28
    implicitWidth: 28
    radius: width / 2
    color: prevHover.hovered ? Colors.activeBtnVibrant : "black"

    Behavior on color {
        ColorAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    Text {
        text: ""
        color: "white"
        anchors.centerIn: parent
    }

    HoverHandler { id: prevHover }

    MouseArea {
        anchors.fill: parent
        onClicked: prevMonthRoot.clicked()
    }
}
