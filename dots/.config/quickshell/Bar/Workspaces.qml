import Quickshell.Hyprland
import QtQuick
import qs.modules.theme

// qmllint disable unqualified

Row {
    spacing: 6
    clip: true

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            id: workspaceSlot
            required property var modelData

            implicitWidth: modelData.active ? Variables.workspaceActiveSize : Variables.workspaceInactiveSize
            implicitHeight: Variables.workspaceInactiveSize
            clip: true

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }

            Rectangle {
                id: workspaceDots
                anchors.centerIn: parent
                anchors.fill: parent

                implicitWidth: modelData.active ? Variables.workspaceActiveSize : Variables.workspaceInactiveSize
                implicitHeight: Variables.workspaceInactiveSize
                radius: height / 2

                color: modelData.active ? Colors.primary : Colors.inverse_primary

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 240
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    modelData.activate();
                }
            }
        }
    }
}

