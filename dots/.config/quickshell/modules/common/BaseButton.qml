import QtQuick
import qs.modules.theme

Rectangle {
    id: buttonRoot

    property string icon: ""
    property int iconSize: Variables.fontLargest
    property bool active: false
    property color activeColor: Colors.primary
    property color inactiveColor: Colors.surface_container_high
    property bool isHovered: mouseArea.containsMouse

    signal clicked()
    signal rightClicked()

    implicitWidth: Variables.buttonHeightMedium
    implicitHeight: Variables.buttonHeightMedium
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

    Text {
        anchors.centerIn: parent
        font.pixelSize: buttonRoot.iconSize
        font.family: Variables.defaultFontFamily
        color: buttonRoot.active ? Colors.on_primary : Colors.on_surface
        text: buttonRoot.icon

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
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
