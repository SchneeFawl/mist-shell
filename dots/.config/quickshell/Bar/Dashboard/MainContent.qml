import QtQuick
// import qs.modules.theme

Rectangle {
    id: contentRoot

    property int activeTab
    property string systemStatsText: "System Stats Placeholder"
    property string appSelectorText: "App Selector Placeholder"
    property string settingsText: "Settings Placeholder"

    anchors.fill: parent
    color: "transparent"
    clip: true

    Loader {
        active: parent.activeTab === 1
        anchors.fill: parent
        source: "widgets/MediaPlayer.qml"
    }

    Text {
        visible: parent.activeTab === 2
        anchors.centerIn: parent
        color: "white"
        text: parent.systemStatsText
    }

    Loader {
        active: parent.activeTab === 3
        anchors.fill: parent
        source: "widgets/ThemeSelector.qml"
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
