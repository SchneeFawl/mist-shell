import QtQuick
import QtQuick.Layouts
import "./components"
import qs.modules.theme

Rectangle {
    id: quickControlsRoot

    property int rootWidth: (controlsLayout.rectSize * 4) + (35)
    property bool gameModeActive: false
    property bool bluetoothActive: false
    property bool dndActive: false

    color: Colors.pillBorder
    implicitHeight: 80
    implicitWidth: rootWidth
    radius: Variables.dashboardRadius - 4
    anchors.horizontalCenter: parent.horizontalCenter
    clip: true

    RowLayout {
        id: controlsLayout
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: Variables.dashInnerColSpacing
        clip: true

        property int rectSize: 60

        QuickControlsButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            Text {
                color: "white"; font.pixelSize: 30; anchors.centerIn: parent
                text: Icons.sysDnd
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
                text: Icons.sysBluetooth
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
                text: Icons.sysGameMode
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
                text: Icons.sysClipboard
            }
        }
    }
}