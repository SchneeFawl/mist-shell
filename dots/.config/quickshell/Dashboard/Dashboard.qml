import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.theme
import qs.services

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

    visible: active || _wasActive
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
                if (dashboardPopup.closeTimer) dashboardPopup.closeTimer.start();
            }
        }
    }

    Rectangle {
        id: dashboardBg

        property alias centerPill: dashboardPopup.centerPill
        property alias active: dashboardPopup.active

        implicitWidth: centerPill ? (active ? dashboardPopup.implicitWidth : centerPill.width) : 0
        implicitHeight: centerPill ? (active ? dashboardPopup.implicitHeight : centerPill.height) : 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        radius: active ? Variables.dashboardRadius : Variables.dashboardRadius / 2
        color: Colors.surface
        border.color: Colors.border
        border.width: 1
        clip: true

        states: [
            State {
                name: "active"
                when: dashboardPopup.active
                PropertyChanges {
                    dashboardBg.implicitWidth: dashboardPopup.implicitWidth
                    dashboardBg.implicitHeight: dashboardPopup.implicitHeight
                }
            },
            State {
                name: "inactive"
                when: !dashboardPopup.active
                PropertyChanges {
                    dashboardBg.implicitWidth: centerPill?.width ?? 0
                    dashboardBg.implicitHeight: centerPill?.height ?? 0
                }
            }
        ]

        transitions: [
            Transition {
                from: "inactive"; to: "active"
                NumberAnimation {
                    properties: "implicitWidth,implicitHeight"
                    duration: Variables.durationSlow
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.entranceCurve
                }
            },

            Transition {
                from: "active"; to: "inactive"

                SequentialAnimation {

                    NumberAnimation {
                        properties: "implicitWidth,implicitHeight"
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.exitCurve
                    }
                    ScriptAction {
                        script: {
                            dashboardPopup._wasActive = false;
                            gc();
                        }
                    }
                }
            }
        ]

        Behavior on radius {
            NumberAnimation { duration: Variables.durationMedium }
        }

        HoverHandler {
            id: dashboardPopupHover
            onHoveredChanged: {
                if (hovered && dashboardPopup.closeTimer) {
                    dashboardPopup.closeTimer.stop();
                } else if (!hovered && dashboardPopup.closeTimer && !ThemeController.keyboardFocus) {
                    dashboardPopup.closeTimer.start();
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
