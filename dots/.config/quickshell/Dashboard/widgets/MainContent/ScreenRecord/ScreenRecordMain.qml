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

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Variables.dashInnerColSpacing
        implicitWidth: parent.width
        implicitHeight: 36
        spacing: Variables.dashInnerColSpacing

        Rectangle {
            id: headerTextContainer
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

        ScreenRecordBtn {
            icon: Icons.sysSettings
            onClicked: recMainRoot.StackView.view.push("ScreenRecordSettings.qml")
        }
    }
}
