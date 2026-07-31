import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: searchBar

    property string searchQuery: ""

    anchors.leftMargin: Variables.spacingNormal
    anchors.rightMargin: Variables.spacingNormal
    anchors.topMargin: Variables.spacingNormal
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    implicitHeight: Math.round(40 * Variables.scaleFactor)
    color: Colors.surface_container_high
    radius: width / 2
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

            StyledText {
                id: searchPlaceholder
                color: Colors.surface_variant
                text: "Search clipboard..."
                visible: searchBar.searchQuery.length === 0
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
