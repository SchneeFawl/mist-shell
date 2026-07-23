import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import "./SettingsMenu"

Rectangle {
    id: settingsRoot

    // anchors.fill: parent
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

            Rectangle {
                id: scaleHighlight

                property var hoveredPill: {
                    scalePill1.isHovered ? scalePill1 : (
                        scalePill2.isHovered ? scalePill2 : (
                            scalePill3.isHovered ? scalePill3 : (
                                scalePill4.isHovered ? scalePill4 : null
                            )
                        )
                    )
                }
                property var activePill: {
                    (SettingsService.scaleFactor === 1) ? scalePill1 : (
                        (SettingsService.scaleFactor === 1.25) ? scalePill2 : (
                            (SettingsService.scaleFactor === 1.5) ? scalePill3 : scalePill4
                        )
                    )
                }
                property var targetPill: hoveredPill ?? activePill

                height: parent.height
                width: targetPill?.width ?? 0
                x: targetPill?.x ?? 0
                radius: Variables.dashInnerRadius
                color: Colors.primary
                opacity: targetPill ? 1.0 : 0

                Behavior on x {
                    NumberAnimation {
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationFast
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }
            }

            RowLayout {
                id: scalePillsRow
                anchors.fill: parent
                spacing: 0

                SettingsPill {
                    id: scalePill1
                    text: "1.0"
                    highlighted: scaleHighlight.targetPill === scalePill1
                    onClicked: SettingsService.scaleFactor = 1.0
                }
                SettingsPill {
                    id: scalePill2
                    text: "1.25"
                    highlighted: scaleHighlight.targetPill === scalePill2
                    onClicked: SettingsService.scaleFactor = 1.25
                }
                SettingsPill {
                    id: scalePill3
                    text: "1.50"
                    highlighted: scaleHighlight.targetPill === scalePill3
                    onClicked: SettingsService.scaleFactor = 1.50
                }
                SettingsPill {
                    id: scalePill4
                    text: "2.0"
                    highlighted: scaleHighlight.targetPill === scalePill4
                    onClicked: SettingsService.scaleFactor = 2.0
                }
            }
        }

        Item { Layout.fillHeight: true }    // filler
    }
}
