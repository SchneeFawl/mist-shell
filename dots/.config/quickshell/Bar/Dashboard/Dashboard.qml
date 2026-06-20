import QtQuick
import Quickshell
import qs.modules.theme

// qmllint disable unqualified

PopupWindow {
    id: dashboardPopup

    required property bool active
    required property var centerPill
    required property var closeTimer

    property bool _wasActive: false

    onActiveChanged: {
        if (active) _wasActive = true;
    }

    visible: active || (widthAnimation.running && _wasActive)
    color: "transparent"
    grabFocus: true

    anchor {
        item: centerPill
        edges: Edges.Top                            // qmllint disable missing-type
        gravity: Edges.Bottom                       // qmllint disable missing-type
    }
    implicitWidth: 1000
    implicitHeight: 400

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
                duration: 250
                easing.type: Easing.OutCubic

                onRunningChanged: {
                    if (!running && !dashboardPopup.active) {
                        dashboardPopup._wasActive = false;
                    }
                }
            }
        }

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        Behavior on radius {
            NumberAnimation { duration: 250 }
        }

        HoverHandler {
            id: dashboardPopupHover
            onHoveredChanged: {
                if (hovered && closeTimer) {
                    closeTimer.stop();
                } else if (!hovered && closeTimer) {
                    closeTimer.start();
                }
            }
        }

        DashboardColumns { active: dashboardPopup.active }
    }
}
