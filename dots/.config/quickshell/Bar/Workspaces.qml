import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: workspaceContainer
    spacing: 0

    // model data which maps the hyprland workspace indices
    property int currentActiveWorkspace: 1

    Repeater {
        model: Hyprland.workspaces

        Rectangle {         // delegate of the repeater
            id: indicatorDot
            required property var modelData
            /* property bool isActive: modelData === workspaceContainer.currentActiveWorkspace */

            width: modelData.active ? 12 : 6
            height: 6
            radius: 3

            color: modelData.active ? themePalette.activeAccent : themePalette.inactiveAccent

            // smooth physical scaling adjustments when changing workspaces
            Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
            Behavior on color { ColorAnimation { duration: 200 } }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: { modelData.activate() }
            }
        }
    }
}
