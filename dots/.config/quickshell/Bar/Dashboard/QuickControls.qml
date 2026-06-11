import QtQuick
import QtQuick.Layouts
import "./components"

// qmllint disable unqualified

Rectangle {
    id: quickControlsRoot

    property int rootWidth: (controlsLayout.rectSize * 4) + (35)
    property bool gameModeActive: false
    property bool bluetoothActive: false
    property bool dndActive: false

    color: themePalette.pillBorder
    implicitHeight: 80
    implicitWidth: rootWidth
    radius: 24
    anchors.horizontalCenter: parent.horizontalCenter
    clip: true

    // QuickControlsButton { id: controlsLayout }
    RowLayout {
        id: controlsLayout
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 5
        clip: true

        property int rectSize: 60

        QuickControlsButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            Text {
                color: "white"; font.pixelSize: 30; anchors.centerIn: parent
                text: "󰂛"
            }

            onClicked: {
                if (!active) {
                    active = true
                } else {
                    active = false
                }
            }
        }

        QuickControlsButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            Text {
                color: "white"; font.pixelSize: 28; anchors.centerIn: parent
                text: "󰂯"
            }

            onClicked: {
                if (!active) {
                    active = true
                } else {
                    active = false
                }
            }
        }

        QuickControlsButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            Text {
                anchors.centerIn: parent; color: "white"; font.pixelSize: 32
                text: "󰊗"
            }

            onClicked: {
                if (!active) {
                    active = true
                } else {
                    active = false
                }
            }
        }

        QuickControlsButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            Text {
                color: "white"; font.pixelSize: 26; anchors.centerIn: parent
                text: "󰅍"
            }
        }
    }
}