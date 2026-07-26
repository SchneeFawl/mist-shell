import QtQuick
import QtQuick.Layouts
import "../components"
import qs.modules.theme
import qs.modules.common
import qs.services

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
        Layout.preferredHeight: buttonsLayout.implicitHeight
        color: "transparent"
        radius: Variables.dashInnerRadius

        ColumnLayout {
            id: buttonsLayout
            anchors.fill: parent
            spacing: Variables.dashInnerColSpacing

            BaseButton {
                property bool muted: Audio.sinkMuted

                Layout.alignment: Qt.AlignHCenter
                btnSize: Variables.buttonHeightMedium - (Variables.dashInnerColSpacing * 2)
                color: active ? (muted ? Colors.error : Colors.primary) : Colors.surface_container_high
                icon: muted ? Icons.sysVolumeMute : Icons.sysVolume
                iconSize: Variables.iconNormal
                onClicked: {
                    if (root.activeOption === 1 && Audio.sink && Audio.sink.audio) {
                        Audio.sink.audio.muted = !Audio.sink.audio.muted
                    } else root.activeOption = 1
                }
                active: root.activeOption === 1
            }

            BaseButton {
                property bool muted: Audio.sourceMuted

                Layout.alignment: Qt.AlignHCenter
                btnSize: Variables.buttonHeightMedium - (Variables.dashInnerColSpacing * 2)
                color: active ? (muted ? Colors.error : Colors.primary) : Colors.surface_container_high
                icon: muted ? Icons.sysMicMute : Icons.sysMic
                iconSize: Variables.iconNormal
                onClicked: {
                    if (root.activeOption === 2 && Audio.source && Audio.source.audio) {
                        Audio.source.audio.muted = !Audio.source.audio.muted
                    } else root.activeOption = 2
                }
                active: root.activeOption === 2
            }

            BaseButton {
                Layout.alignment: Qt.AlignHCenter
                btnSize: Variables.buttonHeightMedium - (Variables.dashInnerColSpacing * 2)
                icon: Icons.sysBrightness
                iconSize: Variables.iconNormal
                onClicked: {
                    root.activeOption = 3
                }
                active: root.activeOption === 3
            }
        }
    }

    VerticalSlider {
        id: volumeSlider
        visible: root.activeOption === 1
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
        visible: root.activeOption === 2
        value: Audio.sourceValue
        muted: Audio.sourceMuted
        onSliderMoved: (value) => {
            if (Audio.source && Audio.source.audio) {
                Audio.source.audio.volume = value;
            }
        }
    }

    // (placeholder)
    VerticalSlider {
        id: brightnessSlider
        visible: root.activeOption === 3
    }
}
