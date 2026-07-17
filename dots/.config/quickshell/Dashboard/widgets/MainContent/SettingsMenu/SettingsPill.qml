import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: stngPillRoot

    signal clicked()
    property string text: ""
    property bool highlighted: false
    property bool active: false
    property bool isHovered: mouseArea.containsMouse

    Layout.preferredHeight: parent.height
    Layout.fillWidth: true
    radius: Variables.dashInnerRadius
    color: "transparent"

    Text {
        id: optionText
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.defaultFontSize
        color: stngPillRoot.highlighted ? Colors.on_primary : Colors.on_surface
        text: stngPillRoot.text

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
        hoverEnabled: true
        onClicked: stngPillRoot.clicked()
    }
}
