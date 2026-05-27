import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 10
    Layout.alignment: Qt.AlignHCenter

    Repeater {
        model: Hyprland.workspaces

        Rectangle {         // delegate of the repeater
            id: indicatorDot
            required property var modelData

	    implicitWidth: modelData.active ? 18 : 10
            height: 10
            radius: 5
            Layout.alignment: Qt.AlignVCenter

            color: modelData.active ? themePalette.activeAccent : themePalette.inactiveAccent

            // smooth physical scaling adjustments when changing workspaces
	    Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
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
