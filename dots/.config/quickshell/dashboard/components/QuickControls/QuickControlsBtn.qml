import QtQuick
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: controlsButtonRoot

    property string icon: ""
    property int iconSize: Variables.iconLarge

    property bool active: false
    signal clicked()
    signal rightClicked()

    radius: Variables.dashColumnRadius
    color: active ? Colors.primary : Colors.surface_container_high
    clip: true
    scale: mouseArea.pressed ? 0.85 : 1.0

    StyledText {
        anchors.centerIn: parent
        color: controlsButtonRoot.active ? Colors.on_primary : Colors.on_surface
        font.pixelSize: controlsButtonRoot.iconSize
        text: controlsButtonRoot.icon
    }

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
            if (mouse.button === Qt.LeftButton) {
                controlsButtonRoot.clicked();
            } else {
                controlsButtonRoot.rightClicked();
            }
        }
    }
}
