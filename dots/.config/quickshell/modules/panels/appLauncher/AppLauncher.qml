import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.modules.theme
import qs.modules.common

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    visible: AppLauncherService.visible

    implicitWidth: Math.round(460 * Variables.scaleFactor)
    implicitHeight: Math.round(530 * Variables.scaleFactor)

    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "mist:app_launcher"

    Rectangle {
        id: rootContainer

        anchors.fill: parent
        radius: Variables.radiusLarge
        border.width: 2
        border.color: Colors.border
        color: Qt.alpha(Colors.secondary_container, 0.8)   // opacity will decrease opacity of child elements

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            anchors.leftMargin: Variables.spacingLarge
            anchors.rightMargin: Variables.spacingLarge
            anchors.topMargin: Variables.spacingLarge
            spacing: Variables.spacingMedium

            AppLauncherHeader {}

            AppLauncherSearchBar {}

            Item { Layout.fillHeight: true }
        }
    }
}

