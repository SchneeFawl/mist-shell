import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.modules.common
import qs.modules.theme
import qs.services

Rectangle {
    id: root

    required property ListView listView
    required property var modelData
    required property int index

    property bool selected: AppLauncherService.filteredApps[listView.currentIndex] === modelData

    color: selected ? Colors.secondary : Colors.secondary_container
    radius: Variables.radiusNormal
    scale: mouseArea.pressed ? 0.90 : 1.0

    RowLayout {
        anchors.fill: parent
        anchors.margins: Variables.spacingNormal
        spacing: Variables.spacingNormal

        IconImage {
            Layout.preferredWidth: Variables.buttonHeightSmall
            Layout.preferredHeight: Variables.buttonHeightSmall
            asynchronous: true
            mipmap: true
            source: Quickshell.iconPath(root.modelData.icon)
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Variables.spacingSmall

            StyledText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: Variables.fontMedium
                color: root.selected ? Colors.on_secondary : Colors.secondary
                text: root.modelData.name
            }

            StyledText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: Variables.fontSmall
                color: root.selected ? Colors.secondary_container : Colors.on_secondary_container
                text: root.modelData.comment || ""
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (root.listView.currentIndex === root.index) {
                AppLauncherService.launchApp(root.modelData);
            } else {
                root.listView.currentIndex = root.index;
            }
        }
    }
}

