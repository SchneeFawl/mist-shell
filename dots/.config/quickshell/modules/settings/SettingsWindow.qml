pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Window {
    id: root

    maximumHeight: Math.round(700 * Variables.scaleFactor)
    maximumWidth: Math.round(1000 * Variables.scaleFactor)
    minimumHeight: Math.round(500 * Variables.scaleFactor)
    minimumWidth: Math.round(800 * Variables.scaleFactor)
    color: Qt.alpha(Colors.surface_container_low, Variables.panelOpacity)
    visible: SettingsService.windowVisible
    flags: Qt.Window | Qt.FramelessWindowHint

    onVisibleChanged: {
        if (visible) {
            root.requestActivate();
        } else {
            SettingsService.windowVisible = false;
        }
    }

    onClosing: (close) => {
        SettingsService.windowVisible = false;
    }

    RowLayout {
        id: masterRow
        anchors.fill: parent
        anchors.margins: Variables.spacingNormal
        spacing: Variables.spacingNormal

        SettingsSidebar { id: sidebar }

        SettingsContent {
            pages: sidebar.pages
            currentPage: sidebar.currentPage
        }

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Escape) {
                SettingsService.windowVisible = false;
            }
        }
    }
}

