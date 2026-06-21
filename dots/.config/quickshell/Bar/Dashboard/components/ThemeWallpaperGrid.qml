pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme
import qs.services

GridView {
    id: wallpaperGrid

    required property var filteredWallpapers

    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true

    reuseItems: true
    cellHeight: 110
    cellWidth: width / 2
    boundsBehavior: Flickable.StopAtBounds

    model: filteredWallpapers
    delegate: Item {
        required property var modelData

        width: wallpaperGrid.cellWidth
        height: wallpaperGrid.cellHeight

        Rectangle {
            id: card

            anchors.fill: parent
            anchors.margins: 4
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
            border.color: {
                ThemeController.wallpaper === parent.modelData ? Colors.primary
                : (wallpaperMouseArea.containsMouse ? Colors.border : "transparent")
            }
            border.width: ThemeController.wallpaper === modelData ? 2 : 1
            clip: true

            ClippingRectangle {
                anchors.fill: parent
                anchors.margins: 4
                radius: Variables.dashInnerRadius - anchors.margins
                color: "transparent"
                clip: true

                Image {
                    id: wallpaperImage
                    anchors.fill: parent
                    asynchronous: true
                    mipmap: true
                    cache: true
                    visible: true
                    sourceSize: Qt.size(parent.width, parent.height)
                    fillMode: Image.PreserveAspectCrop
                    source: ThemeController.wallpaperPath + modelData
                }
            }

            MouseArea {
                id: wallpaperMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    ThemeController.updateState(ThemeController.theme, modelData, ThemeController.mode)
                }
            }
        }
    }
}
