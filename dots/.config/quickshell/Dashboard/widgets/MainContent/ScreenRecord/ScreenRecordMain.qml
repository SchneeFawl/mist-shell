import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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

        ScreenRecordText {
            text: "Test"
            leftPadding: Variables.dashInnerColSpacing
        }

        Item { Layout.fillHeight: true }        // filler
    }
}
