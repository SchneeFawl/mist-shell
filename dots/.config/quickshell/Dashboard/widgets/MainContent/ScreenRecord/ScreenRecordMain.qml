import QtQuick
import QtQuick.Layouts
import QtQuick.Controls         // qmllint disable unused-imports
import qs.services
import qs.modules.theme

Item {
    id: recMainRoot

    function formatTime(seconds) {
        const totalSeconds = Math.floor(seconds);
        const mins = Math.floor(totalSeconds / 60)
        const secs = totalSeconds % 60

        if (secs < 10) {
            return (mins < 10 ? 0 : "") + mins + ":" + 0 + secs
        } else {
            return (mins < 10 ? 0 : "") + mins + ":" + secs
        }
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
            implicitWidth: parent.width
            spacing: Variables.dashInnerColSpacing

            Rectangle {
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                color: Colors.surface_container_high
                radius: Variables.dashInnerRadius

                ScreenRecordText {
                    anchors.centerIn: parent
                    text: "Screen Recorder"
                    size: Variables.fontMedium
                }
            }

            ScreenRecordBtn {
                id: headerText
                icon: Icons.sysSettings
                onClicked: recMainRoot.StackView.view.push("ScreenRecordSettings.qml")
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 12

                Rectangle {
                    id: recordIndicator
                    Layout.preferredHeight: Math.round(80 * Variables.scaleFactor)
                    Layout.preferredWidth: Math.round(80 * Variables.scaleFactor)
                    Layout.alignment: Qt.AlignHCenter
                    radius: Variables.dashInnerRadius + 10
                    color: ScreenRecordService.status === "recording" ? Colors.error : (
                        (ScreenRecordService.status === "replay") ? Colors.error : "transparent"
                    )
                    border.width: ScreenRecordService.status === "recording" ? 0 : (
                        (ScreenRecordService.status === "replay") ? 4 : 2
                    )
                    border.color: ScreenRecordService.status === "recording" ? "transparent" : (
                        (ScreenRecordService.status === "replay") ? Colors.error_container : Colors.border
                    )

                    ScreenRecordText {      // idle icon
                        anchors.centerIn: parent
                        size: Variables.buttonHeightMedium
                        color: Colors.error
                        text: Icons.record
                        opacity: ScreenRecordService.status === "idle" ? 1 : 0
                        visible: opacity > 0
                        Behavior on opacity { NumberAnimation { duration: Variables.durationSlow } }
                    }

                    ScreenRecordText {      // recording icon
                        anchors.centerIn: parent
                        size: Variables.buttonHeightMedium
                        color: Colors.on_error
                        text: Icons.recording
                        opacity: ScreenRecordService.status === "recording" ? 1 : 0
                        visible: opacity > 0
                        Behavior on opacity { NumberAnimation { duration: Variables.durationSlow } }
                    }

                    ScreenRecordText {      // replay icon
                        anchors.centerIn: parent
                        size: Variables.buttonHeightMedium
                        color: Colors.on_error
                        text: Icons.replay
                        opacity: ScreenRecordService.status === "replay" ? 1 : 0
                        visible: opacity > 0
                        Behavior on opacity { NumberAnimation { duration: Variables.durationSlow } }
                    }

                    SequentialAnimation {
                        running: ScreenRecordService.status !== "idle"
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: recordIndicator
                            property: "opacity"
                            to: 0.4
                            duration: 1000
                        }
                        NumberAnimation {
                            target: recordIndicator
                            property: "opacity"
                            to: 1.0
                            duration: 1000
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Variables.durationSlow
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.standardCurve
                        }
                    }

                    Behavior on border.color {
                        ColorAnimation {
                            duration: Variables.durationSlow
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.standardCurve
                        }
                    }
                }

                ScreenRecordText {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    size: Variables.fontMedium
                    color: Colors.on_surface
                    text: ScreenRecordService.status === "recording" ? "Recording screen" : (
                        (ScreenRecordService.status === "replay") ? "Replay Buffer active" : "Ready"
                    )
                }

                ScreenRecordText {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    size: Variables.fontSmall
                    color: Colors.on_surface
                    opacity: 0.8
                    text: recMainRoot.formatTime(ScreenRecordService.elapsedSeconds)
                    visible: ScreenRecordService.status === "recording"
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            Layout.rightMargin: Variables.dashInnerColSpacing
            Layout.leftMargin: Variables.dashInnerColSpacing
            clip: true

            RowLayout {
                id: idleRow
                width: parent.width
                height: parent.height
                x: 0
                Layout.leftMargin: Variables.dashInnerColSpacing
                Layout.rightMargin: Variables.dashInnerColSpacing
                visible: opacity > 0
                spacing: Variables.dashInnerColSpacing
                y: ScreenRecordService.status === "idle" ? 0 : Variables.buttonHeight
                opacity: ScreenRecordService.status === "idle" ? 1 : 0

                Behavior on y {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                ScreenRecordBtn {
                    fillWidth: true
                    text: "Record"
                    icon: Icons.record
                    onClicked: ScreenRecordService.startRecording()
                }

                ScreenRecordBtn {
                    fillWidth: true
                    text: "Replay"
                    icon: Icons.replay
                    onClicked: ScreenRecordService.startReplay()
                }
            }

            RowLayout {
                id: recordingRow
                width: parent.width
                height: parent.height
                x: 0
                Layout.leftMargin: Variables.dashInnerColSpacing
                Layout.rightMargin: Variables.dashInnerColSpacing
                visible: opacity > 0
                spacing: Variables.dashInnerColSpacing
                y: ScreenRecordService.status === "recording" ? 0 : Variables.buttonHeight
                opacity: ScreenRecordService.status === "recording" ? 1 : 0

                Behavior on y {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                ScreenRecordBtn {
                    fillWidth: true
                    text: "Stop Recording"
                    icon: Icons.stopRecording
                    textColor1: Colors.on_error
                    textColor2: Colors.on_error_container
                    color: mouseArea.pressed ? Colors.error_container : Colors.error
                    onClicked: ScreenRecordService.stopRecording()
                }
            }

            RowLayout {
                id: replayRow
                width: parent.width
                height: parent.height
                x: 0
                Layout.leftMargin: Variables.dashInnerColSpacing
                Layout.rightMargin: Variables.dashInnerColSpacing
                visible: opacity > 0
                spacing: Variables.dashInnerColSpacing
                y: ScreenRecordService.status === "replay" ? 0 : Variables.buttonHeight
                opacity: ScreenRecordService.status === "replay" ? 1 : 0

                Behavior on y {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationSlow
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                ScreenRecordBtn {
                    fillWidth: true
                    text: "Save Clip"
                    icon: Icons.save
                    textColor1: Colors.on_primary
                    textColor2: Colors.on_primary_container
                    color: mouseArea.pressed ? Colors.primary_container : Colors.primary
                    onClicked: ScreenRecordService.saveReplay()
                }

                ScreenRecordBtn {
                    fillWidth: true
                    text: "Stop Replay"
                    icon: Icons.close
                    onClicked: ScreenRecordService.stopReplay()
                }
            }
        }

        Item { Layout.preferredHeight: Variables.dashInnerColSpacing }        // filler
    }
}
