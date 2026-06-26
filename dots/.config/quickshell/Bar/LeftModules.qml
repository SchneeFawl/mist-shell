import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import "./components"

RowLayout {
    spacing: Variables.pillOuterSpacing

    // custom logo
    Pill {
        Row {
            Layout.fillHeight: true
            spacing: 8

            BarText {
                text: Icons.barIcon
                color: Colors.primary
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            BarText {
                text: "mist"
                anchors.verticalCenter: parent.verticalCenter
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

            BarText {
                id: keybindText
                anchors.centerIn: parent
                text: Icons.barShortcuts
                font.pixelSize: 18
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

