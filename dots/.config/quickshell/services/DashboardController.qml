pragma Singleton
import QtQuick

QtObject {
    id: dashControl

    property int activeTab: 1           // defaults to media mode
    property bool active: false
    property bool keyboardFocus: false
}
