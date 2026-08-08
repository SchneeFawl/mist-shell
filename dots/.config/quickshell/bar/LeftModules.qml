import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services
import "./components"

RowLayout {
    spacing: Variables.pillOuterSpacing

    Pill {
        Row {
            Layout.fillHeight: true
            spacing: Variables.spacingNormal

            StyledText {
                color: Colors.primary
                monospace: true
                font.pixelSize: Variables.fontMedium
                anchors.verticalCenter: parent.verticalCenter
                text: Icons.barIcon
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.primary
                text: "mist"
            }
        }
    }

    // keybinds trigger
    Pill {
        id: keybindPill
        innerPadding: Variables.spacingSmall
        pillSpacing: Variables.spacingSmall

        MouseArea {
            id: keybindHelper
            Layout.preferredWidth: Math.round(24 * Variables.scaleFactor)
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: console.log("[Keybinds] Keybind helper clicked")

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconSmall
                text: Icons.keyboard
                color: Colors.primary
            }
        }

        MouseArea {
            id: clipboard
            Layout.preferredWidth: Math.round(24 * Variables.scaleFactor)
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: CliphistService.panelVisible = !CliphistService.panelVisible

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconSmall
                color: Colors.primary
                text: Icons.clipboard
            }
        }
    }

    // workspaces
    Pill {
        innerPadding: Variables.spacingNormal
        Workspaces {}
    }
}
