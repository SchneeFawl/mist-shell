import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common
import "./components"

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

            // font size multiplier
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

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
                    Layout.leftMargin: Variables.spacingSmall
                    Layout.rightMargin: Variables.spacingSmall
                    spacing: Variables.spacingLarge

                    StyledText {
                        Layout.fillHeight: true
                        Layout.alignment: Text.AlignVCenter
                        monospace: true
                        font.pixelSize: Variables.fontNormal
                        text: String(Math.round(SettingsService.appearance.fontSizeMultiplier * 100)) + "%"
                    }

                    StyledStepSlider {
                        id: fontSizeSlider
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
                        onClicked: {
                            let defaultValue = 1.0;
                            fontSizeSlider.value = defaultValue;
                            SettingsService.appearance.fontSizeMultiplier = defaultValue;
                        }
                    }
                }
            }

            // radius multiplier
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Radius"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        elide: Text.ElideRight
                        maximumLineCount: 3
                        wrapMode: Text.WordWrap
                        color: Colors.secondary
                        text: "Multiplier to increase or decrease the radius of the overall interface"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: Variables.spacingSmall
                    Layout.rightMargin: Variables.spacingSmall
                    spacing: Variables.spacingLarge

                    StyledText {
                        Layout.fillHeight: true
                        Layout.alignment: Text.AlignVCenter
                        monospace: true
                        font.pixelSize: Variables.fontNormal
                        text: String(Math.round(SettingsService.appearance.radiusMultiplier * 100)) + "%"
                    }

                    StyledStepSlider {
                        id: radiusSlider
                        Layout.fillWidth: true
                        Layout.preferredHeight: handleSize + Variables.spacingSmall
                        value: SettingsService.appearance.radiusMultiplier
                        onValueCommitted: (finalValue) => {
                            SettingsService.appearance.radiusMultiplier = finalValue;
                        }
                    }

                    BaseButton {
                        Layout.preferredHeight: Variables.buttonHeightSmall
                        Layout.preferredWidth: Variables.buttonHeightSmall
                        color: "transparent"
                        iconSize: Variables.iconLarge
                        icon: Icons.restoreDefault
                        onClicked: {
                            let defaultValue = 1.0;
                            radiusSlider.value = defaultValue;
                            SettingsService.appearance.radiusMultiplier = defaultValue;
                        }
                    }
                }
            }

            // spacing multiplier
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Spacing"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        font.pixelSize: Variables.fontSmall
                        elide: Text.ElideRight
                        maximumLineCount: 3
                        wrapMode: Text.WordWrap
                        color: Colors.secondary
                        text: "Multiplier to increase or decrease spacing of the overall interface"
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: Variables.spacingSmall
                    Layout.rightMargin: Variables.spacingSmall
                    spacing: Variables.spacingLarge

                    StyledText {
                        Layout.fillHeight: true
                        Layout.alignment: Text.AlignVCenter
                        monospace: true
                        font.pixelSize: Variables.fontNormal
                        text: String(Math.round(SettingsService.appearance.spacingMultiplier * 100)) + "%"
                    }

                    StyledStepSlider {
                        id: spacingSlider
                        Layout.fillWidth: true
                        Layout.preferredHeight: handleSize + Variables.spacingSmall
                        value: SettingsService.appearance.spacingMultiplier
                        onValueCommitted: (finalValue) => {
                            SettingsService.appearance.spacingMultiplier = finalValue;
                        }
                    }

                    BaseButton {
                        Layout.preferredHeight: Variables.buttonHeightSmall
                        Layout.preferredWidth: Variables.buttonHeightSmall
                        color: "transparent"
                        iconSize: Variables.iconLarge
                        icon: Icons.restoreDefault
                        onClicked: {
                            let defaultValue = 1.0;
                            spacingSlider.value = defaultValue;
                            SettingsService.appearance.spacingMultiplier = defaultValue;
                        }
                    }
                }
            }

            // icon size multiplier
            SliderEntry {
                entryText: "Icon size"
                entryDesc: "Multiplier to increase or decrease icon sizes"
                sliderValue: SettingsService.appearance.iconSizeMultiplier
                sliderTextValue: String(Math.round(SettingsService.appearance.iconSizeMultiplier * 100) + "%")
                onSliderValueCommitted: (finalValue) => {
                    SettingsService.appearance.iconSizeMultiplier = finalValue;
                }
                onBtnClicked: {
                    let defaultValue = SettingsDefaults.appearance.iconSizeMultiplier;
                    value = defaultValue;
                    SettingsService.appearance.iconSizeMultiplier = defaultValue;
                }
            }
        }
    }
}
