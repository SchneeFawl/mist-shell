import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: btButtonRoot

    signal clicked()

    Layout.fillHeight: true
    Layout.preferredWidth: height
    color: backMouseArea.pressed ? Colors.primary : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: backMouseArea.pressed ? 0.85 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 240
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
        font.pixelSize: 12
        renderType: Text.NativeRendering
        color: backMouseArea ? Colors.on_primary : Colors.on_surface
        text: Icons.chevronLeft

        Behavior on color {
            ColorAnimation {
                duration: 240
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        id: backMouseArea
        anchors.fill: parent
        onClicked: btButtonRoot.clicked()
    }
}
