import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.theme
import qs.services

// qmllint disable unqualified

PopupWindow {
    id: dashboardPopup

    required property bool active
    required property var centerPill
    required property var closeTimer

    property bool _wasActive: false

    onActiveChanged: {
        if (active) {
            _wasActive = true;
        } else {
            ThemeController.keyboardFocus = false;
        }
    }

    visible: active || (widthAnimation.running && _wasActive)
    color: "transparent"

    anchor {
        item: centerPill
        edges: Edges.Top                            // qmllint disable missing-type
        gravity: Edges.Bottom                       // qmllint disable missing-type
    }
    implicitWidth: 1000
    implicitHeight: 400

    HyprlandFocusGrab {
        active: ThemeController.keyboardFocus && dashboardPopup.visible
        windows: [ dashboardPopup ]
        onCleared: ThemeController.keyboardFocus = false
    }

    Connections {
        target: ThemeController

        function onKeyboardFocusChanged() {
            if (!ThemeController.keyboardFocus && !dashboardPopupHover.hovered) {
                if (closeTimer) closeTimer.start();
            }
        }
    }

    Rectangle {
        id: dashboardBg

        implicitWidth: centerPill ? (active ? dashboardPopup.implicitWidth : centerPill.width) : 0
        implicitHeight: centerPill ? (active ? dashboardPopup.implicitHeight : centerPill.height) : 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        radius: active ? Variables.dashboardRadius : Variables.dashboardRadius / 2
        color: Colors.surface
        border.color: Colors.border
        border.width: 1
        clip: true

        Behavior on implicitWidth {
            NumberAnimation {
                id: widthAnimation
                duration: Variables.durationSlow
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve

                onRunningChanged: {
                    if (!running && !dashboardPopup.active) {
                        dashboardPopup._wasActive = false;
                        gc();
                    }
                }
            }
        }

        Behavior on implicitHeight {
            NumberAnimation {
                duration: Variables.durationSlow
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        Behavior on radius {
            NumberAnimation { duration: 300 }
        }

        HoverHandler {
            id: dashboardPopupHover
            onHoveredChanged: {
                if (hovered && closeTimer) {
                    closeTimer.stop();
                } else if (!hovered && closeTimer && !ThemeController.keyboardFocus) {
                    closeTimer.start();
                }
            }
        }

        Loader {
            id: dashLoader
            active: dashboardPopup.active || dashboardPopup._wasActive
            anchors.fill: parent
            source: "DashboardColumns.qml"

            Binding {
                target: dashLoader.item
                property: "active"
                value: dashboardPopup.active
            }
        }
    }
}
