import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: durationPillRoot

    signal clicked()
    property bool editable: false
    property bool active: false

    Layout.preferredHeight: parent.height
    Layout.fillWidth: true
    radius: Variables.dashInnerRadius
    color: active ? Colors.primary : Colors.surface_container_highest
    scale: mouseArea.pressed ? 0.85 : 1.0

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

    TextInput {
        anchors.centerIn: parent
        color: Colors.on_surface
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        cursorVisible: true
        clip: true
    }

    Text {
        anchors.centerIn: parent
        color: Colors.on_surface
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: durationPillRoot.clicked()
    }
}
