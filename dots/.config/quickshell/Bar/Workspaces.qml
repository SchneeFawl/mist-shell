import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 2

    Repeater {
        model: Hyprland.workspaces

        delegate: Item { 	// the delegate
            id: workspaceSlot
            required property var modelData

            implicitWidth: 24
            implicitHeight: 24

            Rectangle {         // outer ring of the Repeater
                id: outerRing
                anchors.centerIn: parent

                width: modelData.active ? 22 : 10
                height: modelData.active ? 22 : 10
                radius: width / 2

                color: themePalette.inactiveAccent
                // border.color: themePalette.activeAccent
                // border.width: 1

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

            Rectangle {		// the core center dot indicator
                id: centerDot
                anchors.centerIn: parent

                width: 6
                height: 6
                radius: 3

                color: modelData.active ? themePalette.activeAccent : themePalette.inactiveAccent

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

