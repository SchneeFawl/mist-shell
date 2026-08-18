pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.modules.theme

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
        // opacity property will decrease opacity of child elements
        color: Qt.alpha(Colors.secondary_container, Variables.panelOpacity)

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            anchors.margins: Variables.spacingLarge
            spacing: Variables.spacingMedium

            AppLauncherHeader {}

            AppLauncherSearchBar {
                listView: listView
            }

            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: Variables.spacingSmall
                clip: true
                model: AppLauncherService.filteredApps
                delegate: AppLauncherItem {
                    implicitHeight: Variables.buttonHeightLarge
                    implicitWidth: mainColumn.width
                }
            }
        }
    }

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape) {
            AppLauncherService.visible = false;
            event.accepted = true;
        }
    }
}

