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
            Layout.preferredHeight: 36
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
                    size: 16
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
                // anchors.fill: parent
                anchors.centerIn: parent
                implicitHeight: 140
                implicitWidth: 200
                spacing: 8

                Rectangle {
                    id: recordIndicator
                    Layout.preferredHeight: 80
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignHCenter
                    radius: Variables.dashInnerRadius + 10
                    color: ScreenRecordService.status === "recording" ? Colors.error : (
                        (ScreenRecordService.status === "replay") ? Colors.error : "transparent"
                    )
                    border.width: ScreenRecordService.status === "recording" ? 0 : (
                        (ScreenRecordService.status === "replay") ? 4 : 2
                    )
                    border.color: ScreenRecordService.status === "recording" ? "transparent" : (
                        (ScreenRecordService.status === "replay") ? Colors.primary : Colors.border
                    )

                    ScreenRecordText {
                        anchors.centerIn: parent
                        size: 50
                        color: ScreenRecordService.status === "recording" ? Colors.tertiary : (
                            (ScreenRecordService.status === "replay") ? Colors.tertiary : Colors.error
                        )
                        text: ScreenRecordService.status === "recording" ? Icons.recording : (
                            (ScreenRecordService.status === "replay") ? Icons.replay : Icons.record
                        )
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
                }

                ScreenRecordText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    size: 15
                    color: Colors.on_surface
                    text: ScreenRecordService.status === "recording" ? "Recording screen" : (
                        (ScreenRecordService.status === "replay") ? "Replay Buffer active" : "Ready"
                    )
                }
            }
        }

        // Item { Layout.fillHeight: true }        // filler
    }
}
