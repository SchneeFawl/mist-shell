import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

RowLayout {
    id: root

    Layout.fillWidth: true

    spacing: Variables.spacingNormal

    StyledText {
        Layout.alignment: Text.AlignVCenter
        font.pixelSize: Variables.fontLarge
        font.weight: Variables.defaultFontWeight + 100
        color: Colors.primary
        text: "Apps " + Icons.dot + " " + AppLauncherService.totalAppCount
    }

    Item { Layout.fillWidth: true }

    BaseButton {
        Layout.preferredHeight: Variables.buttonHeightSmall
        Layout.preferredWidth: Variables.buttonHeightSmall
        inactiveColor: Colors.secondary_container
        activeColor: Colors.secondary
        textColor: Colors.on_secondary_container
        textActiveColor: Colors.on_secondary
        icon: Icons.close
        onClicked: AppLauncherService.visible = false
    }
}

