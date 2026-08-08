import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import "./SettingsMenu"

Rectangle {
    id: settingsRoot

    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        SettingsHeader { Layout.bottomMargin: Variables.dashInnerColSpacing }

        SettingsText { text: "Scale factor:" }

        Item {
            id: scaleContainer
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight

            StngsPillHighlight {
                id: scaleHighlight

                hoveredPill: {
                    scalePill1.isHovered ? scalePill1 : (
                        scalePill2.isHovered ? scalePill2 : (
                            scalePill3.isHovered ? scalePill3 : (
                                scalePill4.isHovered ? scalePill4 : null
                            )
                        )
                    )
                }
                activePill: {
                    (SettingsService.scaleFactor === 1) ? scalePill1 : (
                        (SettingsService.scaleFactor === 1.25) ? scalePill2 : (
                            (SettingsService.scaleFactor === 1.5) ? scalePill3 : scalePill4
                        )
                    )
                }
            }

            RowLayout {
                id: scalePillsRow
                anchors.fill: parent
                spacing: 0

                SettingsPill {
                    id: scalePill1
                    monospace: true
                    text: "1.0"
                    highlighted: scaleHighlight.targetPill === scalePill1
                    onClicked: SettingsService.scaleFactor = 1.0
                }
                SettingsPill {
                    id: scalePill2
                    monospace: true
                    text: "1.25"
                    highlighted: scaleHighlight.targetPill === scalePill2
                    onClicked: SettingsService.scaleFactor = 1.25
                }
                SettingsPill {
                    id: scalePill3
                    monospace: true
                    text: "1.50"
                    highlighted: scaleHighlight.targetPill === scalePill3
                    onClicked: SettingsService.scaleFactor = 1.50
                }
                SettingsPill {
                    id: scalePill4
                    monospace: true
                    text: "2.0"
                    highlighted: scaleHighlight.targetPill === scalePill4
                    onClicked: SettingsService.scaleFactor = 2.0
                }
            }
        }

        SettingsText {
            Layout.topMargin: Variables.spacingSmall
            text: "Bar media text display style:"
        }

        Item {
            id: mediaTextContainer
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight

            StngsPillHighlight {
                id: mediaTextHighlight

                hoveredPill: {
                    mediaPill1.isHovered ? mediaPill1 :
                        mediaPill2.isHovered ? mediaPill2 : null
                }
                activePill: SettingsService.mediaTextMode === "marquee" ? mediaPill1 : mediaPill2
            }

            RowLayout {
                id: mediaTextPillsRow
                anchors.fill: parent
                spacing: 0

                SettingsPill {
                    id: mediaPill1
                    text: "Marquee"
                    highlighted: mediaTextHighlight.targetPill === mediaPill1
                    onClicked: SettingsService.mediaTextMode = "marquee"
                }
                SettingsPill {
                    id: mediaPill2
                    text: "Elide"
                    highlighted: mediaTextHighlight.targetPill === mediaPill2
                    onClicked: SettingsService.mediaTextMode = "elide"
                }
            }
        }

        Item { Layout.fillHeight: true }    // filler
    }
}
