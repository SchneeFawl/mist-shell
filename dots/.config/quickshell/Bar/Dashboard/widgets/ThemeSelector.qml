import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import qs.services

FocusScope {
    id: root

    anchors.fill: parent

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: "Theme: " + ThemeController.theme
            color: Colors.primary
            font.pixelSize: 18
        }

        Text {
            text: "Theme: " + ThemeController.mode
            color: Colors.textSub
            font.pixelSize: 14
        }

        Text {
            text: "Theme: " + ThemeController.wallpaper
            color: Colors.textSub
            font.pixelSize: 14
        }
    }
}