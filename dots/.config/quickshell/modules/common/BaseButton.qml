import QtQuick
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: buttonRoot

    property int btnSize: Variables.buttonHeight

    property string text: ""
    property int textSize: Variables.fontNormal
    property color textColor: Colors.on_surface
    property color textActiveColor: Colors.on_primary

    property string icon: ""
    property int iconSize: Variables.iconNormal

    property bool active: false
    property bool isHovered: mouseArea.containsMouse

    property color activeColor: Colors.primary
    property color inactiveColor: Colors.surface_container_high

    signal clicked()
    signal rightClicked()

    implicitWidth: btnSize
    implicitHeight: btnSize
    radius: Variables.dashInnerRadius
    color: active ? activeColor : inactiveColor
    scale: mouseArea.pressed ? 0.85 : 1.0
    clip: true

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

    StyledText {
        anchors.centerIn: parent
        monospace: buttonRoot.icon !== ""
        font.pixelSize: buttonRoot.icon ? buttonRoot.iconSize : Variables.fontNormal
        color: buttonRoot.active ? buttonRoot.textActiveColor : buttonRoot.textColor
        text: buttonRoot.icon || buttonRoot.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) buttonRoot.clicked();
            else buttonRoot.rightClicked()
        }
    }
}
