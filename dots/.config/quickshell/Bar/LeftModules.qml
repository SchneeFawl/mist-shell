import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import "./components"

RowLayout {
    spacing: Variables.pillOuterSpacing

    // custom logo
    Pill {
        BarText {
            text: Icons.barIcon
            color: Colors.primary
            font.pixelSize: 16
        }

        BarText {
            text: "mist"
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

