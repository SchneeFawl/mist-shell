import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme
import qs.services
import "../components"

ClippingRectangle {
    id: root

    property string activeMode: ThemeController.mode
    property alias searchQuery: searchBar.searchQuery

    readonly property var activeThemeObject: {
        let list = ThemeController.themeList;
        if (!list) return null;

        for (let i = 0; i < list.length; i++) {
            if (list[i].name === ThemeController.theme) return list[i];
        }
        return null;
    }

    readonly property var filteredWallpapers: {
        let wallpapers = activeThemeObject ? activeThemeObject.wallpapers : [];
        if (!wallpapers) return [];

        let query = root.searchQuery.trim().toLowerCase();
        if (query === "") return wallpapers;
        return wallpapers.filter(w => w.toLowerCase().includes(query));
    }

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing
        z: 100

        ThemeSearchBar {
            id: searchBar
        }

        RowLayout {
            id: controlsRow
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            Layout.fillHeight: false
            spacing: Variables.dashInnerColSpacing
            // z: 100

            ThemeDropdown {
                id: themeDropdown
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ThemeModeToggle {
                currentMode: root.activeMode
            }
        }

        ThemeWallpaperGrid {
            id: wallpaperGrid
            z: -1
            filteredWallpapers: root.filteredWallpapers
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: themeDropdown.expanded
        z: 99
        onClicked: themeDropdown.expanded = false
    }
}