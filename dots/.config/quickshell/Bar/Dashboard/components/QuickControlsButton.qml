import QtQuick
import qs.modules.theme

Rectangle {
    id: controlsButtonRoot

    property bool active: false
    signal clicked()

    radius: 14
    color: active ? Colors.activeBtnVibrant : Colors.inactiveAccent

    Behavior on color {
        ColorAnimation {
            duration: 130
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: controlsButtonRoot.clicked()
    }
}