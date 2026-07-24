import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: searchBar

    property string searchQuery: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 40
    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius
    clip: true

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            font.pixelSize: Variables.iconNormal
            color: Colors.on_primary_container
            text: Icons.magnify
        }

        TextInput {
            id: searchInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillWidth: true
            color: Colors.on_surface
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: true
            clip: true
            onTextChanged: searchBar.searchQuery = text
            enabled: searchBar.visible
            focus: true

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    DashboardController.keyboardFocus = false
                }
            }

            StyledText {
                id: searchPlaceholder
                color: Colors.surface_variant
                text: "Search wallpapers..."
                visible: searchBar.searchQuery.length === 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: !DashboardController.keyboardFocus
        onClicked: {
            DashboardController.keyboardFocus = true;
            searchInput.forceActiveFocus();
        }
    }
}
