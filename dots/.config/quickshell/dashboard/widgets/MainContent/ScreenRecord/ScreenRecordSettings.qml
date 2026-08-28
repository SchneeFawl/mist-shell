import QtQuick
import QtQuick.Controls         // qmllint disable unused-imports
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Item {
    id: recSettingsRoot

    MouseArea {
        anchors.fill: parent
        onClicked: recSettingsRoot.forceActiveFocus()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        RowLayout {
            id: headerContainer
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            Layout.bottomMargin: Variables.dashInnerColSpacing

            // back btn
            ScreenRecordBtn {
                icon: Icons.chevronLeft
                onClicked: recSettingsRoot.StackView.view.pop()
            }

            // header
            Rectangle {
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                color: Colors.surface_container_high
                radius: Variables.dashInnerRadius

                ScreenRecordText {
                    anchors.centerIn: parent
                    font.family: Variables.sansFontFamily
                    font.weight: Variables.defaultFontWeight + 100
                    text: "Screen Recorder"
                    size: Variables.fontMedium
                }
            }
        }

        ScreenRecordText {
            id: replayDurationText
            text: "Replay duration (seconds)"
            leftPadding: Variables.dashInnerColSpacing
        }

        Item {
            id: durationContainer
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight

            Rectangle {
                id: slidingHighlight

                property var hoveredPill: {
                    pill1.isHovered ? pill1 : (
                        pill2.isHovered ? pill2 : (
                            pill3.isHovered ? pill3 : (
                                pill4.isHovered ? pill4 : null
                            )
                        )
                    )
                }
                property var activePill: {
                    (ScreenRecordService.replayDuration) === 60 ? pill1 : (
                        (ScreenRecordService.replayDuration === 90) ? pill2 : (
                            (ScreenRecordService.replayDuration === 120) ? pill3 : pill4
                        )
                    )
                }
                property var targetPill: hoveredPill ? hoveredPill : activePill

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
                id: durationPillRow
                anchors.fill: parent
                spacing: 0

                SRPill {
                    id: pill1
                    editable: false
                    monoText: true
                    staticText: "60s"
                    active: ScreenRecordService.replayDuration === 60
                    highlighted: slidingHighlight.targetPill === pill1
                    onClicked: ScreenRecordService.replayDuration = 60
                }

                SRPill {
                    id: pill2
                    editable: false
                    monoText: true
                    staticText: "90s"
                    active: ScreenRecordService.replayDuration === 90
                    highlighted: slidingHighlight.targetPill === pill2
                    onClicked: ScreenRecordService.replayDuration = 90
                }

                SRPill {
                    id: pill3
                    editable: false
                    monoText: true
                    staticText: "120s"
                    active: ScreenRecordService.replayDuration === 120
                    highlighted: slidingHighlight.targetPill === pill3
                    onClicked: ScreenRecordService.replayDuration = 120
                }

                Item { Layout.preferredWidth: Variables.dashInnerColSpacing - 2 }      // filler

                SRPill {
                    id: pill4
                    editable: true
                    monoText: true
                    valueText: ScreenRecordService.replayDuration.toString()
                    highlighted: slidingHighlight.targetPill === pill4
                    active: ![60, 90, 120].includes(ScreenRecordService.replayDuration)
                }

                Item { Layout.preferredWidth: Variables.dashInnerColSpacing }      // filler

                ScreenRecordBtn {
                    icon: Icons.checkMark
                    pressedColor: Colors.primary
                    textColor2: Colors.on_primary
                    onClicked: ScreenRecordService.replayDuration = parseInt(pill4.inputText)
                }
            }
        }

        ScreenRecordText {
            id: selectQualityText
            Layout.topMargin: Variables.spacingNormal
            text: "Select recording quality:"
            leftPadding: Variables.dashInnerColSpacing
        }

        SRQualityDropdown {}

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            Layout.topMargin: Variables.spacingSmall

            ScreenRecordText {
                id: recordAudioText
                Layout.fillWidth: true
                text: "Record audio:"
                leftPadding: Variables.dashInnerColSpacing
            }

            ScreenRecordToggle {
                Layout.preferredHeight: parent.height - Variables.spacingSmall
                Layout.preferredWidth: parent.height + Math.round(20 * Variables.scaleFactor)
                Layout.alignment: Qt.AlignVCenter
                Layout.rightMargin: Variables.spacingSmall + Math.round(2 * Variables.scaleFactor)
            }
        }

        Item {
            id: colorRangeContainer
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            Layout.topMargin: Variables.spacingSmall

            Rectangle {
                id: colorRangeHighlight

                property var hoveredPill: colorLimitedPill.isHovered ? colorLimitedPill : (
                    colorFullPill.isHovered ? colorFullPill : null
                )
                property var activePill: ScreenRecordService.colorRange === "limited" ? colorLimitedPill : colorFullPill
                property var targetPill: hoveredPill ? hoveredPill : activePill

                height: parent.height
                width: targetPill?.width ?? 0
                x: targetPill?.x ?? 0
                radius: Variables.dashInnerRadius
                color: Colors.primary
                opacity: targetPill ? 1 : 0

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
                anchors.fill: parent
                spacing: 0

                ScreenRecordText {
                    id: colorModeText
                    Layout.preferredWidth: Math.round(120 * Variables.scaleFactor)
                    text: "Color mode:"
                    leftPadding: Variables.dashInnerColSpacing
                }

                SRPill {
                    id: colorLimitedPill
                    editable: false
                    staticText: "Limited"
                    active: ScreenRecordService.colorRange === "limited"
                    highlighted: colorRangeHighlight.targetPill === colorLimitedPill
                    onClicked: ScreenRecordService.colorRange = "limited"
                }

                SRPill {
                    id: colorFullPill
                    editable: false
                    staticText: "Full"
                    active: ScreenRecordService.colorRange === "full"
                    highlighted: colorRangeHighlight.targetPill === colorFullPill
                    onClicked: ScreenRecordService.colorRange = "full"
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            Layout.topMargin: Variables.spacingSmall
            spacing: Variables.dashInnerColSpacing

            ScreenRecordText {
                id: fpsText
                Layout.preferredWidth: Math.round(120 * Variables.scaleFactor)
                text: "Framerate:"
                leftPadding: Variables.dashInnerColSpacing
            }

            SRPill {
                id: fpsPill
                editable: true
                monoText: true
                valueText: ScreenRecordService.fps.toString()
            }

            ScreenRecordBtn {
                icon: Icons.checkMark
                pressedColor: Colors.primary
                textColor2: Colors.on_primary
                onClicked: ScreenRecordService.fps = parseInt(fpsPill.inputText)
            }
        }

        Item { Layout.fillHeight: true }            // filler
    }
}
