import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.theme

Item {
    id: recSettingsRoot

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        RowLayout {
            id: headerContainer
            Layout.fillWidth: true
            Layout.preferredHeight: 36
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
                    text: "Screen Recorder"
                    size: 16
                }
            }
        }

        ScreenRecordText {
            id: recordAudioText
            text: "Replay duration (seconds)"
            leftPadding: Variables.dashInnerColSpacing
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 36

            SRDurationPill {
                editable: false
                staticText: "60s"
            }

            SRDurationPill {
                editable: false
                staticText: "90s"
            }

            SRDurationPill {
                editable: false
                staticText: "120s"
            }

            SRDurationPill {
                editable: true
            }

            ScreenRecordBtn {
                icon: Icons.checkMark
                pressedColor: Colors.primary
                textColor2: Colors.on_primary
            }
        }

        Item { Layout.fillHeight: true }            // filler
    }
}
