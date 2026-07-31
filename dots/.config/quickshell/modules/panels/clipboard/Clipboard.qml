import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.modules.theme
import qs.modules.common

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    property string searchText: ""
    readonly property var filteredEntries: {
        if (searchText.trim() === "") return CliphistService.entries;
        let query = searchText.toLowerCase();
        return CliphistService.entries.filter(entry => entry.text.toLowerCase().includes(query));
    }

    implicitHeight: Math.round(470 * Variables.scaleFactor)
    implicitWidth: Math.round(320 * Variables.scaleFactor)
    color: "transparent"
    visible: CliphistService.panelVisible

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "clipboard_window"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    // exclusiveZone: -1

    Rectangle {
        anchors.fill: parent
        color: Colors.surface_container_low
        border.color: Colors.border
        border.width: Math.round(2 * Variables.scaleFactor)
        radius: Variables.radiusLarge

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Variables.spacingNormal + Math.round(2 * Variables.scaleFactor)
            spacing: Variables.spacingNormal

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: Variables.buttonHeightMedium
                spacing: Variables.spacingNormal

                StyledText {
                    Layout.fillWidth: true
                    leftPadding: Variables.spacingSmall
                    font.pixelSize: Variables.fontLargest
                    text: "Clipboard"
                }

                Rectangle {  // placeholder
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 36
                }
            }

            ClipboardHeader {
                searchQuery: root.searchText
            }

            Item { Layout.fillHeight: true }     // filler
        }
    }
}
