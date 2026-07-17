import QtQuick
import QtQuick.Layouts
import qs.modules.theme

RowLayout {
    id: headerContainer
    Layout.fillWidth: true
    Layout.preferredHeight: 36
    Layout.bottomMargin: Variables.dashInnerColSpacing

    // header
    Rectangle {
        Layout.preferredHeight: parent.height
        Layout.fillWidth: true
        color: Colors.surface_container_high
        radius: Variables.dashInnerRadius

        SettingsText {
            anchors.centerIn: parent
            text: "Settings"
            size: 16
        }
    }
}
