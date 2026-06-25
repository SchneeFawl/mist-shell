import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: controlsRoot

    property int rootWidth: (controlsLayout.rectSize * 4) + (35)
    property bool bluetoothActive: false

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
            iconSize: 30
            icon: active ? Icons.sysDndActive : Icons.sysDndInactive

            onClicked: {
                active = !active;
                Notifications.dndActive = !Notifications.dndActive;
            }
        }

        // bluetooth button
        QuickControlsBtn {
            id: bluetoothBtn
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            icon: Icons.sysBluetooth

            onClicked: active = !active
        }

        // gamemode button
        QuickControlsBtn {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            iconSize: 32
            icon: Icons.sysGameMode

            onClicked: {
                active = !active;
                GameMode.gameModeActive = !GameMode.gameModeActive
            }
        }

        // caffeine mode button
        QuickControlsBtn {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            iconSize: 30
            icon: Idle.caffeineActive ? Icons.sysCaffeineActive : Icons.sysCaffeineInactive

            onClicked: {
                Idle.caffeineActive = !Idle.caffeineActive;
                active = !active;
            }
        }
    }
}