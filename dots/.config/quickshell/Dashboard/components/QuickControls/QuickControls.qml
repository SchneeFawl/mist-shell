import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.modules.theme
import qs.services

Rectangle {
    id: controlsRoot

    property int rootWidth: (controlsLayout.rectSize * 4) + (35)
    signal bluetoothRightClicked()

    color: Colors.surface_container_low
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

        // dnd button
        QuickControlsBtn {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            icon: active ? Icons.sysDndActive : Icons.sysDndInactive

            onClicked: {
                active = !active;
                Notifications.dndActive = !Notifications.dndActive;
            }
        }

        // qmllint disable
        // bluetooth button
        QuickControlsBtn {
            id: bluetoothBtn
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            icon: Icons.sysBluetooth
            active: Bluetooth.defaultAdapter ? Bluetooth.defaultAdapter.enabled : false

            onClicked: {
                if (Bluetooth.defaultAdapter) {
                    Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
                }
            }

            onRightClicked: controlsRoot.bluetoothRightClicked()
        }
        // qmllint enable

        // gamemode button
        QuickControlsBtn {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            icon: Icons.sysGameMode
            active: GameMode.gameModeActive

            onClicked: {
                GameMode.activate();
                active = GameMode.gameModeActive;
            }
        }

        // caffeine mode button
        QuickControlsBtn {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            icon: Idle.caffeineActive ? Icons.sysCaffeineActive : Icons.sysCaffeineInactive
            active: Idle.caffeineActive

            onClicked: {
                Idle.caffeineActive = !Idle.caffeineActive;
            }
        }
    }
}