import QtQuick
import "./widgets"
// import qs.modules.theme

Rectangle {
    id: root

    property int activeTab
    property string systemStatsText: "System Stats Placeholder"
    property string appSelectorText: "App Selector Placeholder"
    property string settingsText: "Settings Placeholder"

    anchors.fill: parent
    // color: Colors.border
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

    ThemeSelector {
        visible: parent.activeTab === 3 
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
