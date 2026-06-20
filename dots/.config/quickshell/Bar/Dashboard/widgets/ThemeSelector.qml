import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme
import qs.services
import "../components"

ClippingRectangle {
    id: root

    property string activeMode: ThemeController.mode

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        Rectangle {
            id: searchBar
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.fillHeight: false
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius

            Text {
                anchors.centerIn: parent
                color: Colors.textSub
                text: "search bar placeholder"
            }
        }

        RowLayout {
            id: controlsRow
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            Layout.fillHeight: false
            spacing: Variables.dashInnerColSpacing

            Rectangle {
                id: dropdownMenu
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Colors.surface_container_high
                radius: Variables.dashInnerRadius

                Text {
                    anchors.centerIn: parent
                    color: Colors.on_surface
                    text: "Theme: " + ThemeController.theme
                }
            }

            ThemeModeToggle {
                currentMode: root.activeMode
            }
        }

        Item {
            id: wallpaperGrid
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.centerIn: parent
                text: "wallpapers grid placeholder"
                color: Colors.textSub
            }
        }
    }
}