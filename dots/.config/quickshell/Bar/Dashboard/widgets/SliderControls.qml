import QtQuick
import QtQuick.Layouts
import "../components"
import qs.modules.theme
import qs.services

ColumnLayout {
    id: root

    property int activeOption: 1

    anchors.fill: parent
    spacing: Variables.dashInnerColSpacing
    clip: true

    Component.onCompleted: {
        console.log("Current volume: " + Audio.sinkValue)
    }

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
                icon: muted ? Icons.sysVolumeMute : Icons.sysVolume
                muted: Audio.sinkMuted
                onClicked: {
                    if (root.activeOption === 1) {
                        Audio.sink.audio.muted = !Audio.sink.audio.muted
                    } else root.activeOption = 1
                }
                active: root.activeOption === 1
            }

            SliderControlsBtn {
                icon: muted ? Icons.sysMicMute : Icons.sysMic
                muted: Audio.sourceMuted
                onClicked: {
                    if (root.activeOption === 2) {
                        Audio.source.audio.muted = !Audio.source.audio.muted
                    } else root.activeOption = 2
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
        value: Audio.sinkValue
        muted: Audio.sinkMuted
        onSliderMoved: (value) => {
            if (Audio.sink && Audio.sink.audio) {
                Audio.sink.audio.volume = value;
            }
        }
    }

    VerticalSlider {
        id: micSlider
        visible: root.activeOption === 2 ? true : false
        value: Audio.sourceValue
        muted: Audio.sourceMuted
        onSliderMoved: (value) => {
            if (Audio.source && Audio.source.audio) {
                Audio.source.audio.volume = value;
            }
        }
    }

    VerticalSlider {
        id: brightnessSlider
        visible: root.activeOption === 3 ? true : false
    }
}