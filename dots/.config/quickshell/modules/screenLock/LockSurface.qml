import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: root

    implicitHeight: Math.round(640 * Variables.scaleFactor)
    implicitWidth: Math.round(900 * Variables.scaleFactor)
    color: "transparent"

    anchors.margins: Variables.spacingLargest

    ColumnLayout {
        id: masterLayout
        spacing: Variables.spacingLarge

        // profile pic
        Rectangle {
            Layout.preferredHeight: Math.round(90 * Variables.scaleFactor)
            Layout.preferredWidth: Math.round(90 * Variables.scaleFactor)
            color: Colors.tertiary
            radius: (height / 2) * Variables.radiusMultiplier

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconLargest
                color: Colors.on_tertiary
                text: Icons.account
            }
        }

        // username
        StyledText {
            Layout.fillWidth: true
            font.pixelSize: Variables.fontMedium
            color: Colors.primary
            text: Quickshell.env("USER")
        }

        // clock
        ColumnLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(60 * Variables.scaleFactor)
            spacing: Variables.spacingMedium

            StyledText {
                monospace: true
                font.pixelSize: Variables.fontLargest
                color: Colors.secondary
                text: Time.timeText
            }

            StyledText {
                font.pixelSize: Variables.spacingMedium
                color: Colors.tertiary
                text: Time.fullDateText
            }
        }
    }
}
