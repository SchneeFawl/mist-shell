import QtQuick
import QtQuick.Layouts
import "./components"

ColumnLayout {
    id: root

    property int activeOption: 1

    anchors.fill: parent
    spacing: 5
    clip: true

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
                onClicked: {
                    root.activeOption = 1
                }
                active: root.activeOption === 1
            }
            SliderControlsBtn {
                Text { text: ""; color: "white"; font.pixelSize: 24; anchors.centerIn: parent }
                onClicked: {
                    root.activeOption = 2
                }
                active: root.activeOption === 2
            }
            SliderControlsBtn {
                Text { text: "󰃟"; color: "white"; font.pixelSize: 24; anchors.centerIn: parent }
                onClicked: {
                    root.activeOption = 3
                }
                active: root.activeOption === 3
            }
        }
    }

    // slider (placeholder)
    VerticalSlider {
        id: volumeSlider
        visible: root.activeOption === 1 ? true : false
    }

    VerticalSlider {
        id: micSlider
        visible: root.activeOption === 2 ? true : false
    }

    VerticalSlider {
        id: brightnessSlider
        visible: root.activeOption === 3 ? true : false
    }
}