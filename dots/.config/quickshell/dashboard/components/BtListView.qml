pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.services
import qs.modules.theme
import qs.modules.common

// qmllint disable unresolved-type

ListView {
    id: btListView
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.topMargin: Variables.spacingSmall
    visible: Bluetooth.defaultAdapter?.enabled ?? false
    clip: true
    spacing: Variables.dashInnerColSpacing

    model: ScriptModel {
        values: BluetoothStatus.sortedDevices
    }

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
            anchors.leftMargin: Variables.spacingMedium
            anchors.rightMargin: Variables.spacingMedium
            spacing: 0
            clip: true

            StyledText {
                id: deviceIcon
                font.pixelSize: Variables.fontLarge
                text: BluetoothStatus.getDeviceIcon(card.modelData.icon)
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: Variables.spacingNormal

                StyledText {
                    id: deviceName
                    font.pixelSize: Variables.fontSmall
                    text: card.fixedDevName
                }

                StyledText {
                    id: deviceStatus
                    font.pixelSize: Variables.fontSmall - 1
                    color: Colors.inactiveAccent
                    text: BluetoothStatus.getStatus(card.modelData)
                }
            }

            Item { Layout.fillWidth: true }     // filler

            ColumnLayout {
                Layout.fillHeight: true
                spacing: Variables.spacingSmall

                // connect/disconnect button
                Rectangle {
                    Layout.preferredHeight: Variables.buttonHeightSmall
                    Layout.preferredWidth: Math.round(86 * Variables.scaleFactor)
                    radius: Variables.dashInnerRadius
                    color: card.modelData.connected ? Colors.surface_container_highest : Colors.primary
                    border.color: Colors.primary
                    border.width: card.modelData.connected ? 1 : 0
                    scale: btnMouseArea.pressed ? 0.85 : 1.0

                    Behavior on scale {
                        NumberAnimation {
                            duration: Variables.durationFast
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.exitCurve
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Variables.durationMedium
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.standardCurve
                        }
                    }

                    StyledText {
                        anchors.centerIn: parent
                        font.pixelSize: card.modelData.connected ? Variables.fontSmall - 1 : Variables.fontSmall
                        color: card.modelData.connected ? Colors.on_surface : Colors.on_primary
                        text: card.modelData.connected ? "Disconnect" : "Connect"
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

                // unpair/forget button
                Rectangle {
                    Layout.preferredHeight: Variables.buttonHeightSmall
                    Layout.preferredWidth: Math.round(86 * Variables.scaleFactor)
                    radius: Variables.dashInnerRadius
                    color: Colors.surface_container_highest
                    border.color: Colors.primary
                    border.width: 1
                    scale: unpairMouseArea.pressed ? 0.85 : 1.0
                    visible: card.modelData.paired

                    Behavior on scale {
                        NumberAnimation {
                            duration: Variables.durationFast
                            easing.type: Easing.Bezier
                            easing.bezierCurve: Variables.exitCurve
                        }
                    }

                    StyledText {
                        anchors.centerIn: parent
                        font.pixelSize: Variables.fontSmall
                        text: "Forget"
                    }

                    MouseArea {
                        id: unpairMouseArea
                        anchors.fill: parent
                        onClicked: card.modelData.forget()
                    }
                }
            }
        }
    }
}
