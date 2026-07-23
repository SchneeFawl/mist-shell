pragma Singleton
import QtQuick

QtObject {
    id: dashControl

    property int activeTab: 1           // defaults to media mode
    property bool active: false
    property bool keyboardFocus: false

    function activeTabPath(index) {
        let path = "widgets/MainContent/";
        switch (index) {
            case 1: return path + "MediaPlayer.qml";
            case 2: return path + "SystemStats.qml";
            case 3: return path + "ThemeSelector.qml";
            case 4: return path + "ScreenRecord.qml";
            case 5: return path + "SettingsMenu.qml";
        }
    }
}
