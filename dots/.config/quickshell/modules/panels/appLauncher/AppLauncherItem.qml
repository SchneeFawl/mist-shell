import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.modules.common
import qs.modules.theme
import qs.services

Rectangle {
    id: root

    required property var modelData
    required property int index

    color: Colors.secondary_container
    radius: Variables.radiusNormal

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
                color: Colors.secondary
                text: root.modelData.name
            }

            StyledText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: Variables.fontSmall
                color: Colors.on_secondary_container
                text: root.modelData.comment || ""
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onDoubleClicked: AppLauncherService.launchApp(root.modelData)
    }
}

