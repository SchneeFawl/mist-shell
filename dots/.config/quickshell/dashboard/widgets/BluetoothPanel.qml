pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Bluetooth
import qs.modules.theme
import qs.modules.common
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
            Layout.preferredHeight: Variables.buttonHeight
            Layout.fillWidth: true

            BtButton {
                id: backButton
                anchors.left: parent.left
                icon: Icons.chevronLeft
                onClicked: btMenuRoot.backClicked()
            }

            StyledText {
                anchors.centerIn: parent
                font.pixelSize: Variables.fontMedium
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

            StyledText {
                anchors.centerIn: parent
                Layout.alignment: Text.AlignHCenter
                text: "Bluetooth is turned off"
            }
        }
    }
}
