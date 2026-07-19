import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.theme
import qs.services

PopupWindow {
    id: dashboardPopup

    required property bool active
    required property var centerPill
    property bool hovered: false

    property bool _wasActive: false

    onActiveChanged: {
        if (active) {
            _wasActive = true;
        } else {
            DashboardController.keyboardFocus = false;
        }
    }

    visible: active || _wasActive
    color: "transparent"

    anchor {
        item: centerPill
        edges: Edges.Top                            // qmllint disable missing-type
        gravity: Edges.Bottom                       // qmllint disable missing-type
    }
    implicitWidth: 1000 * Variables.scaleFactor
    implicitHeight: 400 * Variables.scaleFactor

    HyprlandFocusGrab {
        active: DashboardController.keyboardFocus && dashboardPopup.visible
        windows: [ dashboardPopup ]
        onCleared: DashboardController.keyboardFocus = false
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
                dashboardPopup.hovered = hovered;
                // console.log("[Dashboard] Popup hover changed:", hovered)
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
