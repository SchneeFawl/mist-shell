import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: root

    Layout.fillWidth: true
    Layout.preferredHeight: Math.round(40 * Variables.scaleFactor)
    color: Colors.secondary_container
    radius: Variables.radiusNormal
    clip: true

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: Variables.iconNormal
            color: Colors.tertiary
            text: Icons.magnify
        }

        TextInput {
            id: searchInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillWidth: true
            color: Colors.on_secondary_container
            font.family: Variables.sansFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: true
            clip: true
            onTextChanged: AppLauncherService.searchText = text
            enabled: root.visible
            focus: true

            StyledText {
                id: searchPlaceholder
                color: Colors.tertiary
                text: "Search applications..."
                visible: AppLauncherService.searchText.length === 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            searchInput.forceActiveFocus();
        }
    }
}

