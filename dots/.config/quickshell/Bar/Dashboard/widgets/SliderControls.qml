import QtQuick
import QtQuick.Layouts
import "../components"
import qs.modules.theme

ColumnLayout {
    id: root

    property int activeOption: 1

    anchors.fill: parent
    spacing: Variables.dashInnerColSpacing
    clip: true

    // buttons
    Rectangle {
        Layout.leftMargin: Variables.dashInnerColSpacing
        Layout.rightMargin: Variables.dashInnerColSpacing
        Layout.topMargin: Variables.dashInnerColSpacing
        Layout.fillWidth: true
        Layout.preferredHeight: (40*3) + (4*2)
        color: "transparent"
        radius: Variables.dashInnerRadius

        ColumnLayout {
            anchors.fill: parent
            spacing: Variables.dashInnerColSpacing

            SliderControlsBtn {
                icon: Icons.sysVolume
                onClicked: {
                    root.activeOption = 1
                }
                active: root.activeOption === 1
            }

            SliderControlsBtn {
                icon: Icons.sysMic
                onClicked: {
                    root.activeOption = 2
                }
                active: root.activeOption === 2
            }

            SliderControlsBtn {
                icon: Icons.sysBrightness
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