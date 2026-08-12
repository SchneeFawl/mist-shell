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
                text: Icons.palette
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.fontLargest
                color: Colors.primary
                text: "Appearance"
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

            ColumnLayout {
                Layout.fillWidth: true
                spacing: Variables.spacingMedium

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Font size"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        elide: Text.ElideRight
                        maximumLineCount: 3
                        wrapMode: Text.WordWrap
                        color: Colors.secondary
                        text: "Multiplier to increase or decrease the font size"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingLarge

                    StyledText {
                        monospace: true
                        font.pixelSize: Variables.fontNormal
                        text: String(Math.round(SettingsService.appearance.fontSizeMultiplier * 100)) + "%"
                    }

                    StyledStepSlider {
                        Layout.fillWidth: true
                        Layout.preferredHeight: handleSize + Variables.spacingSmall
                        value: SettingsService.appearance.fontSizeMultiplier
                        onValueCommitted: (finalValue) => {
                            SettingsService.appearance.fontSizeMultiplier = finalValue;
                        }
                    }

                    BaseButton {
                        Layout.preferredHeight: Variables.buttonHeightSmall
                        Layout.preferredWidth: Variables.buttonHeightSmall
                        color: "transparent"
                        iconSize: Variables.iconLarge
                        icon: Icons.restoreDefault
                        onClicked: SettingsService.appearance.fontSizeMultiplier = 1.0
                    }
                }
            }
        }
    }
}
