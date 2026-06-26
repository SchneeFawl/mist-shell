import QtQuick
import qs.modules.theme

Rectangle {
    id: calendarButton

    property string icon: ""
    signal clicked()

    implicitHeight: 28
    implicitWidth: 28
    radius: width / 2
    color: mouseArea.pressed ? Colors.primary : Colors.surface_container_high
    scale: mouseArea.pressed ? 0.80 : 1.0

    Behavior on color {
        ColorAnimation {
            duration: 240
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 240
            easing.type: Easing.OutCubic
        }
    }

    Text {
        anchors.centerIn: parent
        color: mouseArea.pressed ? Colors.on_primary : Colors.on_surface
        font.pixelSize: 12
        text: calendarButton.icon

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
        onClicked: calendarButton.clicked()
    }
}
