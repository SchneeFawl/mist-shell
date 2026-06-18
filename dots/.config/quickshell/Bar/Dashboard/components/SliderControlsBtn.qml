import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: sliderButtonRoot

    property string icon: ""
    // property int iconSize: 

    property int active
    signal clicked()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: active ? Colors.primary : Colors.surface_container_high
    radius: Variables.dashInnerRadius

    Text {
        anchors.centerIn: parent
        color: sliderButtonRoot.active ? Colors.on_primary : Colors.on_surface
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

    clip: true

    MouseArea {
        anchors.fill: parent
        onClicked: sliderButtonRoot.clicked()
    }
}
