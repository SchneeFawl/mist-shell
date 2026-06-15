import QtQuick
import QtQuick.Layouts
import qs.modules.theme

RowLayout {
    spacing: Variables.pillOuterSpacing

    // custom logo
    Pill {
        BarText {
            text: "󱄅"   // I DO NOT USE NIX BTW
            color: Colors.activeAccent
            font.pixelSize: 20
            Layout.alignment: Qt.AlignCenter
        }
        BarText {
            text: "mist"
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignCenter
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
                text: ""
                font.pixelSize: 20
                color: Colors.activeAccent
            }
            onClicked: console.log("trigger keybinds help menu")
        }
    }

    // active window workspace layout panel
    Pill {
        innerPadding: 8
        Workspaces {}
    }
}

