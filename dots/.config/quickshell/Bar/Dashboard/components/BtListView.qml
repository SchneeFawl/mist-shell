pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.services
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
                fixedDevName = devName.substring(0, maxChars);
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
            spacing: 0
            clip: true

            Text {
                id: deviceIcon
                font.family: Variables.defaultFontFamily
                font.pixelSize: 20
                color: Colors.on_surface
                text: BluetoothStatus.getDeviceIcon(card.modelData.icon)
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.leftMargin: 8

                Text {
                    id: deviceName
                    font.family: Variables.defaultFontFamily
                    font.pixelSize: 12
                    color: Colors.on_surface
                    text: card.fixedDevName
                }

                Text {
                    id: deviceStatus
                    font.family: Variables.defaultFontFamily
                    font.pixelSize: 11
                    color: Colors.inactiveAccent
                    text: BluetoothStatus.getStatus(card.modelData)
                }
            }

            Item { Layout.fillWidth: true }     // filler

            // connect/disconnect button
            Rectangle {
                Layout.preferredHeight: 30
                Layout.preferredWidth: 82
                radius: Variables.dashInnerRadius
                color: card.modelData.connected ? Colors.surface_container_highest : Colors.primary
                border.color: Colors.primary
                border.width: card.modelData.connected ? 1 : 0
                scale: btnMouseArea.pressed ? 0.85 : 1.0

                Behavior on scale {
                    NumberAnimation {
                        duration: 240
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 240
                        easing.type: Easing.OutCubic
                    }
                }

                Text {
                    anchors.centerIn: parent
                    font.family: Variables.defaultFontFamily
                    font.pixelSize: card.modelData.connected ? 11 : 12
                    color: card.modelData.connected ? Colors.on_surface : Colors.on_primary
                    text: card.modelData.connected ? "Disconnect" : "Connect"

                    Behavior on color {
                        ColorAnimation {
                            duration: 240
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                MouseArea {
                    id: btnMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (card.modelData.connected) {
                            card.modelData.disconnect()
                        } else {
                            card.modelData.connect()
                        }
                    }
                }
            }
        }
    }
}
