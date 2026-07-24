import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    Layout.preferredHeight: Variables.buttonHeight
    Layout.fillWidth: true
    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius

    SettingsText {
        anchors.centerIn: parent
        text: "Settings"
        size: Variables.fontMedium
    }
}
