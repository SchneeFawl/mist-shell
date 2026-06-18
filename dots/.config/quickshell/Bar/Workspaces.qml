import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.modules.theme

// qmllint disable unqualified

RowLayout {
    spacing: 2

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            id: workspaceSlot
            required property var modelData

            implicitWidth: Variables.workspaceOuterSize
            implicitHeight: Variables.workspaceOuterSize

            Rectangle {         // outer ring of the Repeater
                id: outerRing
                anchors.centerIn: parent

                width: modelData.active ? Variables.workspaceOuterSize : 10
                height: modelData.active ? Variables.workspaceOuterSize : 10
                radius: width / 2

                color: Colors.inverse_primary

                opacity: modelData.active ? 1.0 : 0

                // smooth physical scaling adjustments when changing workspaces
                Behavior on opacity {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }

            Rectangle {		// center dot indicator
                id: centerDot
                anchors.centerIn: parent

                width: Variables.workspaceInnerSize
                height: Variables.workspaceInnerSize
                radius: Variables.workspaceInnerSize / 2

                color: modelData.active ? Colors.activeAccent : Colors.inactiveAccent

                Behavior on color {
                    ColorAnimation {
                        duration: 150
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

