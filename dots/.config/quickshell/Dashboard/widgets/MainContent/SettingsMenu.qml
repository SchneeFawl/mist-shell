import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.theme
import "./SettingsMenu"

Rectangle {
    id: settingsRoot

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        SettingsHeader {}

        SettingsText { text: "Scale factor:" }

        RowLayout {
            id: scaleContainer
            Layout.preferredHeight: 36
            Layout.fillWidth: true
            spacing: 0

            SettingsPill {
                text: "1.0"
                onClicked: SettingsService.scaleFactor = 1.0
            }
            SettingsPill {
                text: "1.25"
                onClicked: SettingsService.scaleFactor = 1.25
            }
            SettingsPill {
                text: "1.50"
                onClicked: SettingsService.scaleFactor = 1.50
            }
            SettingsPill {
                text: "2.0"
                onClicked: SettingsService.scaleFactor = 2.0
            }
        }

        Item { Layout.fillHeight: true }    // filler
    }
}
