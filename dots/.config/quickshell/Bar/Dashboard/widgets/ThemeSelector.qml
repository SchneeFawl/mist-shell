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
        if (!wallpapers) return null;

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
                z: 100
            }

            ThemeModeToggle {
                currentMode: root.activeMode
            }
        }

        Item {
            id: wallpaperGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            z: -1

            Text {
                anchors.centerIn: parent
                text: "wallpapers grid placeholder"
                color: Colors.textSub
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: themeDropdown.expanded
        z: 99
        onClicked: themeDropdown.expanded = false
    }
}