import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: backButton

    signal clicked()
    property bool visibility: false
    property bool highlighted: false

    visible: visibility
    Layout.fillWidth: true
    Layout.preferredHeight: 28
    radius: Variables.pillRadius - 8
    color: backBtnMouse.pressed ? Colors.primary : (
        (backBtnMouse.containsMouse || highlighted)
            ? Colors.surface_container_highest : Colors.surface_container_high
    )
    scale: backBtnMouse.pressed ? 0.85 : 1.0

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Row {
        leftPadding: 8
        anchors.verticalCenter: parent.verticalCenter

        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            color: backBtnMouse.pressed ? Colors.on_primary : Colors.on_surface
            text: Icons.chevronLeft
        }

        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: Variables.spacingSmall
            color: backBtnMouse.pressed ? Colors.on_primary : Colors.on_surface
            text: "Back"
        }
    }

    MouseArea {
        id: backBtnMouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: backButton.clicked()
    }
}
