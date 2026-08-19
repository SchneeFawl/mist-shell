pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Window {
    id: root

    maximumHeight: Math.round(500 * Variables.scaleFactor)
    maximumWidth: Math.round(400 * Variables.scaleFactor)
    minimumHeight: Math.round(370 * Variables.scaleFactor)
    minimumWidth: Math.round(280 * Variables.scaleFactor)
    color: Qt.alpha(Colors.surface_container_low, Variables.panelOpacity)
    visible: CliphistService.panelVisible
    flags: Qt.Window | Qt.FramelessWindowHint

    onVisibleChanged: {
        if (visible) {
            root.requestActivate();
        } else {
            CliphistService.panelVisible = false;
        }
    }

    onClosing: (close) => {
        CliphistService.panelVisible = false;
    }

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
                        color: "transparent"
                        border.color: Colors.secondary
                        border.width: 1
                        icon: Icons.actionDelete
                        text: "Clear"
                        onClicked: CliphistService.wipe()
                    }
                }

                ClipboardHeader {}          // search bar

                // clipboard entries
                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: Variables.spacingNormal
                    spacing: Variables.spacingSmall
                    clip: true

                    model: CliphistService.filteredEntries
                    delegate: ClipboardItem {
                        required property var modelData

                        entryData: modelData
                        onDeleteRequested: CliphistService.deleteEntry(modelData.rawEntry)
                        onCopyRequested: CliphistService.copy(modelData.rawEntry)
                    }

                    displaced: Transition {
                        NumberAnimation {
                            properties: "x,y"
                            duration: Variables.durationMedium
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.standardCurve
                        }
                    }
                    
                    remove: Transition {
                        NumberAnimation {
                            property: "opacity"
                            to: 0.0
                            duration: Variables.durationMedium
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.exitCurve
                        }
                    }
                }
            }
        }
    }
}
