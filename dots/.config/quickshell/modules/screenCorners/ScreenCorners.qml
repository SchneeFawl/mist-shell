import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.theme

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {       // qmllint disable uncreatable-type
        required property var modelData
        readonly property var monitor: Hyprland.monitorFor(modelData)
        readonly property var activeFullscreen: monitor.activeWorkspace.toplevels.values.filter(window => window.wayland?.fullscreen)

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "quickshell:screenCorners"
        WlrLayershell.layer: WlrLayer.Overlay
        mask: Region { item: null }
        visible: activeFullscreen.length === 0

        ScreenCornersItem {
            anchors.top: parent.top
            anchors.left: parent.left
            corner: ScreenCornersItem.CornerEnum.TopLeft
        }
        ScreenCornersItem {
            anchors.top: parent.top
            anchors.right: parent.right
            corner: ScreenCornersItem.CornerEnum.TopRight
        }
        ScreenCornersItem {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            corner: ScreenCornersItem.CornerEnum.BottomLeft
        }
        ScreenCornersItem {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            corner: ScreenCornersItem.CornerEnum.BottomRight
        }
    }
}
