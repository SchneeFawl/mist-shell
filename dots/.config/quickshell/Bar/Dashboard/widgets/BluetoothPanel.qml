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

        Row {
            Layout.preferredHeight: 36
            Layout.fillWidth: true
            // spacing: Variables.dashInnerColSpacing

            BtButton {
                id: backButton
                anchors.left: parent.left
                icon: Icons.chevronLeft
                onClicked: btMenuRoot.backClicked()
            }

            Text {
                anchors.centerIn: parent
                font.family: Variables.defaultFontFamily
                font.pixelSize: 16
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
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
        }
    }
}
