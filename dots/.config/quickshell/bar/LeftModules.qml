import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import "./components"

RowLayout {
    spacing: Variables.pillOuterSpacing

    Pill {
        Row {
            Layout.fillHeight: true
            spacing: Variables.spacingNormal

            StyledText {
                color: Colors.primary
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
        innerPadding: 0

        MouseArea {
            id: keybindHelper
            implicitWidth: keybindText.implicitWidth + 24
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            StyledText {
                id: keybindText
                anchors.centerIn: parent
                font.pixelSize: Variables.fontMedium
                text: Icons.keyboard
                color: Colors.primary
            }
            onClicked: console.log("trigger keybinds help menu")
        }
    }

    // workspaces
    Pill {
        innerPadding: Variables.pillInnerPadding - 4
        Workspaces {}
    }
}
