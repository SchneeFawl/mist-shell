import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: searchBar

    Layout.fillWidth: true
    Layout.preferredHeight: Math.round(40 * Variables.scaleFactor)
    color: Colors.surface_container_high
    radius: Variables.radiusNormal
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
            // onTextChanged: 
            enabled: searchBar.visible
            focus: true

            StyledText {
                id: searchPlaceholder
                color: Colors.surface_variant
                text: "Search settings..."
                visible: !(searchInput.text.length > 0)
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
