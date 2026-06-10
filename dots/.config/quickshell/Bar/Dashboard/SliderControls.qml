import QtQuick
import QtQuick.Layouts
import "./components"

ColumnLayout {
    anchors.fill: parent
    // implicitHeight: (32*3) + 8 + (4*2)
    spacing: 5

    // buttons
    Rectangle {
        Layout.leftMargin: 5
        Layout.rightMargin: 5
        Layout.topMargin: 5
        Layout.fillWidth: true
        Layout.preferredHeight: (40*3) + (4*2)
        color: "transparent"
        radius: 9

        ColumnLayout {
            anchors.fill: parent
            spacing: 4

            SliderControlsBtn {
                Text { text: ""; color: "white"; font.pixelSize: 24; anchors.centerIn: parent }
            }
            SliderControlsBtn {
                Text { text: ""; color: "white"; font.pixelSize: 24; anchors.centerIn: parent }
            }
            SliderControlsBtn {
                Text { text: "󰃟"; color: "white"; font.pixelSize: 24; anchors.centerIn: parent }
            }
        }
    }

    // slider (placeholder)
    VerticalSlider {}
}