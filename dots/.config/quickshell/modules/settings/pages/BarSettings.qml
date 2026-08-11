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
                text: Icons.dockTop
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.fontLargest
                color: Colors.primary
                text: "Bar"
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
            
            // bar position
            RowLayout {
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Position"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                        color: Colors.secondary
                        text: "Sets the position of the bar. Default value: 'top' \n(Still under construction)"
                    }
                }

                Item { Layout.fillWidth: true }

                StyledDropdown {
                    Layout.preferredWidth: Math.round(200 * Variables.scaleFactor)
                    model: ["top", "bottom", "vertical-left", "vertical-right"]
                    selectedText: String(SettingsService.bar.position)
                    onDelegateClicked: (itemData, index) => {
                        SettingsService.bar.position = itemData;
                    }
                    onReturnPressed: (model, currentIndex) => {
                        SettingsService.bar.position = model[currentIndex];
                    }
                }
            }

            // bar style
            RowLayout {
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Style"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                        color: Colors.secondary
                        text: "Style of the bar. Default value: 'fragmented' \n(Still under construction)"
                    }
                }

                Item { Layout.fillWidth: true }

                StyledDropdown {
                    Layout.preferredWidth: Math.round(200 * Variables.scaleFactor)
                    model: ["fragmented", "filled"]
                    selectedText: String(SettingsService.bar.style)
                    onDelegateClicked: (itemData, index) => {
                        SettingsService.bar.style = itemData;
                    }
                    onReturnPressed: (model, currentIndex) => {
                        SettingsService.bar.style = model[currentIndex];
                    }
                }
            }

            // bar media text
            RowLayout {
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Media text mode"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                        color: Colors.secondary
                        text: "Change the style of media text at the center of the bar. Default value: 'marquee' \n(Still under construction)"
                    }
                }

                Item { Layout.fillWidth: true }

                StyledDropdown {
                    Layout.preferredWidth: Math.round(200 * Variables.scaleFactor)
                    model: ["marquee", "elide"]
                    selectedText: String(SettingsService.bar.mediaTextMode)
                    onDelegateClicked: (itemData, index) => {
                        SettingsService.bar.mediaTextMode = itemData;
                    }
                    onReturnPressed: (model, currentIndex) => {
                        SettingsService.bar.mediaTextMode = model[currentIndex];
                    }
                }
            }
        }
    }
}
