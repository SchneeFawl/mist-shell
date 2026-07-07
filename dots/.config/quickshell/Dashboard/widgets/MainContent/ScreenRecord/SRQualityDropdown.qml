import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.modules.theme
import qs.services

Rectangle {
    id: qualityDropdown

    property bool expanded: false

    Layout.preferredWidth: 200
    Layout.preferredHeight: 36
    Layout.leftMargin: Variables.dashInnerColSpacing
    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius
    focus: true

    function formatQualityName(name) {
        if (name === "very_high") return "Very High";
        return name.charAt(0).toUpperCase() + name.slice(1);
    }

    Popup {
        id: qualityMenu

        y: parent.height + 4
        width: parent.width
        height: 36 * 4
        opacity: qualityDropdown.expanded ? 1.0 : 0

        closePolicy: Popup.CloseOnPressOutside || Popup.CloseOnPressOutsideParent
        onClosed: qualityDropdown.expanded = false

        background: Rectangle {
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
        }
    }

    ScreenRecordText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 12
        font.family: Variables.defaultFontFamily
        color: Colors.on_surface
        text: qualityDropdown.formatQualityName(ScreenRecordService.quality)
    }

    ScreenRecordText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        font.family: Variables.defaultFontFamily
        color: Colors.on_surface
        size: 20
        text: Icons.chevronDown
    }

    MouseArea {
        anchors.fill: parent
        onClicked: qualityDropdown.expanded = !qualityDropdown.expanded
    }

    onExpandedChanged: {
        qualityMenu.open();
        qualityMenu.forceActiveFocus();
        DashboardController.keyboardFocus = true;
    }
}
