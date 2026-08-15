import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: root

    Layout.preferredHeight: Math.round(48 * Variables.scaleFactor)
    Layout.preferredWidth: Math.round(300 * Variables.scaleFactor)
    color: Colors.secondary_container
    radius: Variables.radiusLarge
    border.width: 1
    border.color: Colors.secondary

    RowLayout {
        anchors.fill: parent
        anchors.margins: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: Variables.iconMedium
            color: Colors.secondary
            text: Icons.lock
        }

        TextInput {
            id: searchInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Colors.on_surface
            font.family: Variables.sansFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: true
            clip: true
            onTextChanged: {}
            enabled: {}
            focus: true

            StyledText {
                id: searchPlaceholder
                anchors.centerIn: parent
                color: Colors.secondary_container
                text: "Enter your password"
                visible: searchInput.text.length === 0
            }
        }

        BaseButton {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            inactiveColor: Colors.secondary
            activeColor: Colors.primary
            textColor: Colors.on_secondary
            textActiveColor: Colors.on_primary
            iconSize: Variables.iconMedium
            icon: Icons.arrowRight
            onClicked: {}
        }
    }
}
