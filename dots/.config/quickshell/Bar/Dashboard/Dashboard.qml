import QtQuick
import Quickshell

// qmllint disable unqualified

PopupWindow {
    id: dashboardPopup

    required property bool active
    required property var centerPill
    required property var closeTimer

    visible: active || widthAnimation.running
    color: "transparent"

    anchor {
        item: centerPill
        edges: Edges.Top                            // qmllint disable missing-type
        gravity: Edges.Bottom                       // qmllint disable missing-type
    }

    implicitWidth: 700
    implicitHeight: 350

    Rectangle {
        id: dashboardBg

        implicitWidth: centerPill ? (active ? 700 : centerPill.width) : 0
        implicitHeight: centerPill ? (active ? 350 : centerPill.height) : 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        radius: active ? 20 : 12
        color: themePalette.pillBackground
        border.color: themePalette.pillBorder
        border.width: 1

        Behavior on implicitWidth {
            NumberAnimation {
                id: widthAnimation
                duration: 250
                easing.type: Easing.OutCubic
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

        Text {
            anchors.centerIn: parent
            text: "Dashboard"
            color: "#cdd6f4"
            font.pixelSize: 14
            opacity: active ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
    }

    MouseArea {
        anchors.fill: dashboardBg
        hoverEnabled: true

        onEntered: {
            if (closeTimer) closeTimer.stop();
        }
        onExited: {
            if (closeTimer) closeTimer.start();
        }
    }
}
