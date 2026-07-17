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
        anchors.bottomMargin: Variables.dashInnerColSpacing
        anchors.topMargin: Variables.dashInnerColSpacing
        anchors.leftMargin: Variables.dashInnerColSpacing * 2
        anchors.rightMargin: Variables.dashInnerColSpacing * 2
        spacing: Variables.dashInnerColSpacing


        Item { Layout.fillHeight: true }    // filler
    }
}
