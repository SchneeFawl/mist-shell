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
            Layout.preferredHeight: 38

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                color: Colors.surface_container_highest
                radius: Variables.dashInnerRadius
                clip: true
            }
        }

        Item { Layout.fillHeight: true }            // filler
    }
}
