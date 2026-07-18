pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Bluetooth
import qs.modules.theme
import "../components"

// qmllint disable unresolved-type

ClippingRectangle {
    id: btMenuRoot

    signal backClicked()

    color: Colors.surface_container_low
    radius: Variables.dashInnerRadius

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        // header
        Item {
            Layout.preferredHeight: 36
            Layout.fillWidth: true

            BtButton {
                id: backButton
                anchors.left: parent.left
                icon: Icons.chevronLeft
                onClicked: btMenuRoot.backClicked()
            }

            Text {
                anchors.centerIn: parent
                font.family: Variables.defaultFontFamily
                font.pixelSize: Variables.fontMedium
                font.weight: Variables.defaultFontWeight
                color: Colors.on_surface
                text: "Bluetooth"
            }

            BtButton {
                id: scanButton
                anchors.right: parent.right
                icon: Icons.refresh
                onClicked: {
                    if (Bluetooth.defaultAdapter.enabled && !Bluetooth.defaultAdapter.discovering) {
                        Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering
                    }
                    rotationAnim = true
                }
            }
        }

        BtListView {}

        // placeholder
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: !Bluetooth.defaultAdapter || !Bluetooth.defaultAdapter.enabled

            Text {
                anchors.centerIn: parent
                Layout.alignment: Text.AlignHCenter
                font.family: Variables.defaultFontFamily
                font.pixelSize: Variables.fontNormal
                color: Colors.on_surface
                text: "Bluetooth is turned off"
            }
        }
    }
}
