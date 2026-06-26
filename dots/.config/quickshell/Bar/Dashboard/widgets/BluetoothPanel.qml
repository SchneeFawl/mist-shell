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
        RowLayout {
            Layout.preferredHeight: 36
            Layout.fillWidth: true

            BtButton {
                id: backButton
                icon: Icons.chevronLeft
                onClicked: btMenuRoot.backClicked()
            }

            Text {
                Layout.fillWidth: true
                Layout.alignment: Text.AlignHCenter
                font.family: Variables.defaultFontFamily
                font.pixelSize: 16
                font.weight: Variables.defaultFontWeight
                color: Colors.on_surface
                text: "Bluetooth"
            }

            BtButton {
                id: scanButton
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
