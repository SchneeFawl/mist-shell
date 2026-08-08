pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.theme
import qs.services

Window {
    id: root

    maximumHeight: Math.round(700 * Variables.scaleFactor)
    maximumWidth: Math.round(1000 * Variables.scaleFactor)
    minimumHeight: Math.round(500 * Variables.scaleFactor)
    minimumWidth: Math.round(800 * Variables.scaleFactor)
    color: Colors.surface_container_low
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

        SettingsSidebar {}

        SettingsContent {}
    }
}

