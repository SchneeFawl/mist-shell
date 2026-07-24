import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: controlsRoot

    readonly property int padding: Math.round(10 * Variables.scaleFactor)
    signal bluetoothRightClicked()

    color: Colors.surface_container_low
    implicitHeight: controlsLayout.rectSize + (padding * 2)
    implicitWidth: (controlsLayout.rectSize * 4) + (Variables.dashInnerColSpacing * 3)  + (padding * 2)
    radius: Variables.dashboardRadius - 4
    anchors.horizontalCenter: parent.horizontalCenter
    clip: true

    RowLayout {
        id: controlsLayout
        anchors.fill: parent
        anchors.margins: controlsRoot.padding
        spacing: Variables.dashInnerColSpacing
        clip: true

        property int rectSize: Math.round(60 * Variables.scaleFactor)

        // dnd button
        BaseButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            radius: Variables.dashColumnRadius
            iconSize: Variables.iconLarge
            icon: active ? Icons.sysDndActive : Icons.sysDndInactive
            onClicked: {
                active = !active;
                Notifications.dndActive = !Notifications.dndActive;
            }
        }

        // qmllint disable
        // bluetooth button
        BaseButton {
            id: bluetoothBtn
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            radius: Variables.dashColumnRadius
            iconSize: Variables.iconLarge
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
        BaseButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            radius: Variables.dashColumnRadius
            iconSize: Variables.iconLarge
            icon: Icons.sysGameMode
            active: GameMode.gameModeActive
            onClicked: {
                GameMode.activate();
                active = GameMode.gameModeActive;
            }
        }

        // caffeine mode button
        BaseButton {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            radius: Variables.dashColumnRadius
            iconSize: Variables.iconLarge
            icon: Idle.caffeineActive ? Icons.sysCaffeineActive : Icons.sysCaffeineInactive
            active: Idle.caffeineActive
            onClicked: {
                Idle.caffeineActive = !Idle.caffeineActive;
            }
        }
    }
}
