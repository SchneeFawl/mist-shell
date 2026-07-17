import QtQuick
import "./widgets/MainContent"      // qmllint disable unused-imports

Rectangle {
    id: contentRoot

    property int activeTab

    anchors.fill: parent
    color: "transparent"
    clip: true

    Loader {
        active: parent.activeTab === 1
        anchors.fill: parent
        source: "widgets/MainContent/MediaPlayer.qml"
    }

    Loader {
        active: parent.activeTab === 2
        anchors.fill: parent
        source: "widgets/MainContent/SystemStats.qml"
    }

    Loader {
        active: parent.activeTab === 3
        anchors.fill: parent
        source: "widgets/MainContent/ThemeSelector.qml"
    }

    Loader {
        active: parent.activeTab === 4
        anchors.fill: parent
        source: "widgets/MainContent/ScreenRecord.qml"
    }

    Loader {
        active: parent.activeTab === 5
        anchors.fill: parent
        source: "widgets/MainContent/SettingsMenu.qml"
    }
}
