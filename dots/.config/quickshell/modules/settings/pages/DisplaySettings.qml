import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Item {
    id: root
    anchors.fill: parent
    anchors.margins: Variables.spacingNormal

    ColumnLayout {
        id: titleRowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Variables.spacingMedium

        Row {
            spacing: Variables.spacingNormal

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.iconLargest
                color: Colors.primary
                text: Icons.monitor
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.fontLargest
                color: Colors.primary
                text: "Display"
            }
        }

        StyledSeparator {
            Layout.preferredHeight: Math.round(2 * Variables.scaleFactor)
            Layout.fillWidth: true
        }
    }

    Flickable {
        anchors.top: titleRowLayout.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Variables.spacingLarge

        boundsMovement: Flickable.StopAtBounds
        contentHeight: mainColumn.implicitHeight
        maximumFlickVelocity: 3000
        clip: true

        Behavior on contentY {
            NumberAnimation {
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
        }

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            spacing: Variables.spacingLarge

            // scale factor
            RowLayout {
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Scale Factor"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                        color: Colors.secondary
                        text: "Controls scale of the quickshell components. Default value: 1.0"
                    }
                }

                Item { Layout.fillWidth: true }

                StyledDropdown {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Variables.buttonHeight
                    model: [1.0, 1.25, 1.5, 2.0]
                    selectedText: String(SettingsService.scaleFactor)
                    onDelegateClicked: (itemData, index) => {
                        SettingsService.scaleFactor = itemData;
                    }
                    onReturnPressed: (model, currentIndex) => {
                        SettingsService.scaleFactor = model[currentIndex];
                    }
                }
            }
        }
    }
}
