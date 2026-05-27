import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12
    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

    // custom logo
    Pill {
        innerPadding: 6
        BarText {
            text: "󱄅"   // I DO NOT USE NIX LMAO
            color: themePalette.activeAccent
            font.pixelSize: 20
        }
        BarText {
            text: "mist"
            font.weight: Font.DemiBold
        }
    }

    Pill {
        innerPadding: 10
        MouseArea {
            id: keybindHelper
            Layout.preferredWidth: 15
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            RowLayout {
                anchors.centerIn: parent
                spacing: 6
                BarText {
                    text: ""
                    font.pixelSize: 25
                    color: themePalette.activeAccent
                }
            }
            onClicked: console.log("trigge keybinds help menu")
        }
    }

    // active window workspace layout panel
    Pill {
        innerPadding: 12
        Workspaces {}
    }
}
