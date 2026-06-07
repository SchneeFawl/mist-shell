import QtQuick

Rectangle {
    property int activeTab
    property string mediaText: "Media Mode Placeholder"
    property string systemStatsText: "System Stats Placeholder"
    property string themeText: "Theme Selector Placeholder"
    property string appSelectorText: "App Selector Placeholder"
    property string settingsText: "Settings Placeholder"

    id: root
    anchors.fill: parent
    color: themePalette.pillBorder
    radius: 12

    Text {
        visible: parent.activeTab === 1 ? true : false
        anchors.centerIn: parent
        color: "white"
        text: parent.mediaText
    }

    Text {
        visible: parent.activeTab === 2 ? true : false
        anchors.centerIn: parent
        color: "white"
        text: parent.systemStatsText
    }

    Text {
        visible: parent.activeTab === 3 ? true : false
        anchors.centerIn: parent
        color: "white"
        text: parent.themeText
    }

    Text {
        visible: parent.activeTab === 4 ? true : false
        anchors.centerIn: parent
        color: "white"
        text: parent.appSelectorText
    }

    Text {
        visible: parent.activeTab === 5 ? true : false
        anchors.centerIn: parent
        color: "white"
        text: parent.settingsText
    }
}
