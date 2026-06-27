import QtQuick
import qs.modules.theme

Rectangle {
    id: btButtonRoot

    property string icon: ""
    signal clicked()

    height: 36
    width: 36
    color: backMouseArea.pressed ? Colors.surface_container_highest : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: backMouseArea.pressed ? 0.85 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 120
            easing.type: Easing.OutCubic
        }
    }

    Behavior on color  {
        ColorAnimation {
            duration: 240
            easing.type: Easing.OutCubic
        }
    }

    Text {
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 20
        color: Colors.on_surface
        text: btButtonRoot.icon
    }

    MouseArea {
        id: backMouseArea
        anchors.fill: parent
        onClicked: btButtonRoot.clicked()
    }
}
