import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: stngPillRoot

    signal clicked()
    property string text: ""
    property bool highlighted: false
    property bool active: false
    property bool isHovered: mouseArea.containsMouse

    property bool monospace: false

    Layout.preferredHeight: parent.height
    Layout.fillWidth: true
    radius: Variables.dashInnerRadius
    color: "transparent"

    StyledText {
        id: optionText
        anchors.centerIn: parent
        font.family: stngPillRoot.monospace ? Variables.monoFontFamily : Variables.sansFontFamily
        color: stngPillRoot.highlighted ? Colors.on_primary : Colors.on_surface
        text: stngPillRoot.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: stngPillRoot.clicked()
    }
}
