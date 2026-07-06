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

            // back btn
            ScreenRecordBtn {
                Layout.fillHeight: true
                icon: Icons.chevronLeft
                onClicked: recSettingsRoot.StackView.view.pop()
            }

            // header
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: Colors.surface_container_high
                radius: Variables.dashInnerRadius

                Text {
                    anchors.centerIn: parent
                    font.family: Variables.defaultFontFamily
                    font.pixelSize: 16
                    color: Colors.on_surface
                    text: "Screen Recorder"
                }
            }
        }

        Text {
            id: recordAudioText
            verticalAlignment: Text.AlignVCenter
            font.family: Variables.defaultFontFamily
            font.pixelSize: 13
            color: Colors.on_surface
            text: "Replay duration (seconds)"
        }
    }
}
