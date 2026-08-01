pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Window {       // qmllint disable uncreatable-type
    id: root

    maximumHeight: Math.round(500 * Variables.scaleFactor)
    maximumWidth: Math.round(400 * Variables.scaleFactor)
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
                clip: true

                RowLayout {
                    id: headerRow
                    Layout.fillWidth: true
                    Layout.preferredHeight: Variables.buttonHeightMedium
                    spacing: Variables.spacingNormal
                    clip: true

                    StyledText {
                        Layout.fillWidth: true
                        bottomPadding: Variables.spacingNormal
                        leftPadding: Variables.spacingSmall
                        font.pixelSize: Variables.fontLargest
                        text: "Clipboard"
                    }
                    
                    ClipboardButton {
                        icon: Icons.actionDelete
                        text: "Clear"
                        onClicked: CliphistService.wipe()
                    }
                }

                ClipboardHeader {}          // contains the search bar

                ClipboardItem {}
            }
        }
    }
}
