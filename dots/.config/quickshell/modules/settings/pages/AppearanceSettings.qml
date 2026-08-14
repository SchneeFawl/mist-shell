import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common
import "./components"

// qmllint disable missing-property

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
            SliderEntry {
                entryText: "Font size"
                entryDesc: "Multiplier to increase or decrease the font size"
                sliderValue: SettingsService.appearance.fontSizeMultiplier
                sliderTextValue: String(Math.round(SettingsService.appearance.fontSizeMultiplier * 100) + "%")
                onSliderValueCommitted: finalValue => {
                    SettingsService.appearance.fontSizeMultiplier = finalValue;
                }
                onBtnClicked: {
                    let defaultVal = SettingsDefaults.appearance.fontSizeMultiplier;
                    value = defaultVal;
                    SettingsService.appearance.fontSizeMultiplier = defaultVal;
                }
            }

            // radius multiplier
            SliderEntry {
                entryText: "Radius"
                entryDesc: "Multiplier to increase or decrease the radius of the overall interface"
                sliderValue: SettingsService.appearance.radiusMultiplier
                sliderTextValue: String(Math.round(SettingsService.appearance.radiusMultiplier * 100) + "%")
                onSliderValueCommitted: finalValue => {
                    SettingsService.appearance.radiusMultiplier = finalValue;
                }
                onBtnClicked: {
                    let defaultVal = SettingsDefaults.appearance.radiusMultiplier;
                    value = defaultVal;
                    SettingsService.appearance.radiusMultiplier = defaultVal;
                }
            }

            // spacing multiplier
            SliderEntry {
                entryText: "Spacing"
                entryDesc: "Multiplier to increase or decrease spacing of the overall interface"
                sliderValue: SettingsService.appearance.spacingMultiplier
                sliderTextValue: String(Math.round(SettingsService.appearance.spacingMultiplier * 100) + "%")
                onSliderValueCommitted: finalValue => {
                    SettingsService.appearance.spacingMultiplier = finalValue;
                }
                onBtnClicked: {
                    let defaultVal = SettingsDefaults.appearance.spacingMultiplier;
                    value = defaultVal;
                    SettingsService.appearance.spacingMultiplier = defaultVal;
                }
            }

            // icon size multiplier
            SliderEntry {
                entryText: "Icon size"
                entryDesc: "Multiplier to increase or decrease icon sizes"
                sliderValue: SettingsService.appearance.iconSizeMultiplier
                sliderTextValue: String(Math.round(SettingsService.appearance.iconSizeMultiplier * 100) + "%")
                onSliderValueCommitted: finalValue => {
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
