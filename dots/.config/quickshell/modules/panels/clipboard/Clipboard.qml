pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Window {       // qmllint disable uncreatable-type
    id: root

    property string searchText: ""
    readonly property var filteredEntries: {
        if (searchText.trim() === "") return CliphistService.entries;
        let query = searchText.toLowerCase();
        return CliphistService.entries.filter(entry => entry.text.toLowerCase().includes(query));
    }

    maximumHeight: Math.round(500 * Variables.scaleFactor)
    maximumWidth: Math.round(370 * Variables.scaleFactor)
    minimumHeight: Math.round(370 * Variables.scaleFactor)
    minimumWidth: Math.round(280 * Variables.scaleFactor)
    color: Colors.surface_container_low
    visible: CliphistService.panelVisible
    flags: Qt.Window | Qt.FramelessWindowHint

    Loader {
        id: contentLoader
        anchors.fill: parent
        active: CliphistService.panelVisible

        sourceComponent: Component { 
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Variables.spacingNormal + Math.round(2 * Variables.scaleFactor)
                spacing: Variables.spacingNormal

                RowLayout {
                    id: headerRow
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
}
