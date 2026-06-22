import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: sliderButtonRoot

    property string icon: ""
    property bool muted: false

    property int active
    signal clicked()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: active ? (muted ? Colors.tertiary : Colors.primary) : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: mouseArea.pressed ? 0.85 : 1.0

    Text {
        anchors.centerIn: parent
        color: {
            sliderButtonRoot.active
            ? ( sliderButtonRoot.muted ? Colors.on_tertiary : Colors.on_primary)
            : Colors.on_surface
        }
        font.pixelSize: Variables.dashIconSize
        text: sliderButtonRoot.icon

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

    Behavior on scale {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    clip: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: sliderButtonRoot.clicked()
    }
}
