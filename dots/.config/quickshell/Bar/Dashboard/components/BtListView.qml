pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.modules.theme

// qmllint disable unresolved-type

ListView {
    id: btListView
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.topMargin: 3
    visible: Bluetooth.defaultAdapter.enabled
    clip: true
    spacing: Variables.dashInnerColSpacing
    model: Bluetooth.defaultAdapter ? Bluetooth.defaultAdapter.devices : null

    delegate: Rectangle {
        id: card

        required property var modelData
        readonly property string devName: modelData.deviceName !== "" ? modelData.deviceName : "Generic device"
        property string fixedDevName: {
            let maxChars = 18

            if (devName.length > maxChars) {
                fixedDevName = devName.substring(0, maxChars) + "..";
                return fixedDevName;
            } else return devName;
        }

        implicitHeight: 80
        implicitWidth: btListView.width
        radius: Variables.dashInnerRadius
        color: Colors.surface_container_high

        RowLayout {
            id: cardLayout
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8
            clip: true

            Text {
                id: deviceName
                font.family: Variables.defaultFontFamily
                font.pixelSize: 12
                color: Colors.on_surface
                text: card.fixedDevName
            }
        }
    }
}
