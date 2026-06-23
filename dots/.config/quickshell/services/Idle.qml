pragma Singleton
import Quickshell
import Quickshell.Wayland
import QtQuick

Singleton {
    id: idle

    property bool caffeineActive: false
    property alias inhibit: idleInhibitor.enabled

    IdleInhibitor {
        id: idleInhibitor
        enabled: idle.caffeineActive

        // a PanelWindow is necessary for IdleInhibitor
        window: PanelWindow {
            implicitHeight: 0
            implicitWidth: 0
            color: "transparent"
            anchors.right: true
            anchors.bottom: true

            mask: Region { item: null }
        }
    }
}
