import QtQuick
import QtQuick.Layouts
import qs.modules.theme
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

        Text {
            Layout.alignment: Text.AlignVCenter
            color: Colors.textVibrant
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.iconNormal
            text: Icons.magnify
        }

        TextInput {
            id: searchInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillWidth: true
            color: Colors.on_surface
            font.family: Variables.defaultFontFamily
            font.pixelSize: 14
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

            Text {
                id: searchPlaceholder
                color: Colors.surface_variant
                font.family: Variables.defaultFontFamily
                font.pixelSize: 14
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
