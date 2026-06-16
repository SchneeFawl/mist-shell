import QtQuick
import "./widgets"
// import qs.modules.theme

Rectangle {
    id: root

    property int activeTab
    // property string mediaText: "Media Mode Placeholder"
    property string systemStatsText: "System Stats Placeholder"
    property string themeText: "Theme Selector Placeholder"
    property string appSelectorText: "App Selector Placeholder"
    property string settingsText: "Settings Placeholder"

    anchors.fill: parent
    // color: Colors.pillBorder
    color: "transparent"

    MediaPlayer {
        visible: parent.activeTab === 1
    }

    Text {
        visible: parent.activeTab === 2
        anchors.centerIn: parent
        color: "white"
        text: parent.systemStatsText
    }

    Text {
        visible: parent.activeTab === 3
        anchors.centerIn: parent
        color: "white"
        text: parent.themeText
    }

    Text {
        visible: parent.activeTab === 4
        anchors.centerIn: parent
        color: "white"
        text: parent.appSelectorText
    }

    Text {
        visible: parent.activeTab === 5
        anchors.centerIn: parent
        color: "white"
        text: parent.settingsText
    }
}
