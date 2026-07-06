import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.theme

Item {
    id: recSettingsRoot

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Variables.dashInnerColSpacing
        implicitWidth: parent.width
        implicitHeight: 36
        spacing: Variables.dashInnerColSpacing

        ScreenRecordBtn {
            icon: Icons.chevronLeft
            onClicked: recSettingsRoot.StackView.view.pop()
        }

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
    }
}
