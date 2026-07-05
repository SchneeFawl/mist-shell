import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: recBtnRoot

    property string icon: ""
    signal clicked()

    Layout.preferredHeight: 36
    Layout.preferredWidth: 36
    radius: Variables.dashInnerRadius
    color: mouseArea.pressed ? Colors.surface_container_highest : Colors.surface_container_high
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

    Text {
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 20
        color: Colors.on_surface
        text: recBtnRoot.icon
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: recBtnRoot.clicked()
    }
}
