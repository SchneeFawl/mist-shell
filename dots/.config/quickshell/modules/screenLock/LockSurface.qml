import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: root

    required property PamContext pamContext

    implicitHeight: Math.round(500 * Variables.scaleFactor)
    implicitWidth: Math.round(760 * Variables.scaleFactor)
    color: Colors.surface_container_low
    radius: Variables.radiusLarge

    ColumnLayout {
        id: masterLayout
        anchors.fill: parent
        anchors.margins: Variables.spacingLargest + Variables.spacingNormal
        spacing: Variables.spacingLargest

        // profile pic
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: Math.round(90 * Variables.scaleFactor)
            Layout.preferredWidth: Math.round(90 * Variables.scaleFactor)
            color: Colors.tertiary
            radius: (height / 2) * Variables.radiusMultiplier

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconLargest * 2
                color: Colors.on_tertiary
                text: Icons.account
            }
        }

        // username
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(50 * Variables.scaleFactor)

            StyledText {
                anchors.centerIn: parent
                font.pixelSize: Variables.fontLargest
                color: Colors.primary
                text: Quickshell.env("USER")
            }
        }

        // clock
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(100 * Variables.scaleFactor)
            spacing: Variables.spacingNormal

            StyledText {
                Layout.alignment: Text.AlignHCenter
                monospace: true
                font.pixelSize: Variables.fontLargest * 2
                font.weight: Variables.defaultFontWeight + 200
                color: Colors.secondary
                text: Time.timeText
            }

            StyledText {
                Layout.alignment: Text.AlignHCenter
                font.pixelSize: Variables.fontLarge
                font.weight: Variables.defaultFontWeight + 100
                color: Colors.tertiary
                text: Time.fullDateText
            }
        }

        Item { Layout.fillHeight: true }

        LockPasswordBox {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: Variables.spacingNormal
            pamContext: root.pamContext
        }
    }

    // emergency btn
    // BaseButton {
    //     anchors.top: parent.top
    //     anchors.left: parent.left
    //     implicitWidth: 100
    //     implicitHeight: 50
    //     radius: Variables.radiusLarge
    //     text: "DEBUG: Unlock"
    //     onClicked: root.pamContext.locked = false;
    // }
}
