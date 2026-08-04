pragma Singleton
import QtQuick
import Quickshell
import qs.modules.theme
import qs.services

Singleton {
    id: root

    property bool visible: false
    property string activeType: ""      // "volume", "mic", "brightness"

    property string icon: ""
    property string title: ""
    property real value: 1.0            // 0.0 - 1.0

    property bool muted: false

    Timer {
        id: hideTimer
        interval: 5000
        running: false
        onTriggered: root.visible = false;
    }

    Timer {
        id: graceTimer
        interval: 2500
        running: false
        onTriggered: root.visible = false; 
    }

    Connections {
        target: Audio
        function onSinkValueChanged() {
            root.show(
                "volume",
                Audio.sinkMuted ? Icons.sysVolumeMute : Icons.sysVolume,
                "Volume",
                Audio.sinkValue,
                Audio.sinkMuted
            )
        }

        function onSinkMutedChanged() {
            root.show(
                "volume",
                Audio.sinkMuted ? Icons.sysVolumeMute : Icons.sysVolume,
                "Volume",
                Audio.sinkValue,
                Audio.sinkMuted
            )
        }

        function onSourceValueChanged() {
            root.show(
                "mic",
                Audio.sourceMuted ? Icons.sysMicMute : Icons.sysMic,
                "Mic volume",
                Audio.sourceValue,
                Audio.sourceMuted
            )
        }

        function onSourceMutedChanged() {
            root.show(
                "mic",
                Audio.sourceMuted ? Icons.sysMicMute : Icons.sysMic,
                "Mic volume",
                Audio.sourceValue,
                Audio.sourceMuted
            )
        }
    }

    Connections {
        target: Brightness
        function onValueChanged() {
            root.show(
                "brightness",
                Icons.sysBrightness,
                "Brightness",
                Brightness.value,
                false
            )
        }
    }

    function stopTimer() {
        hideTimer.stop();
        graceTimer.stop();
    }

    function startGraceTimer() { graceTimer.start(); }

    function show(type, icon, title, val, isMuted = false) {
        graceTimer.stop();
        hideTimer.restart();
        root.visible = true;

        root.activeType = type;
        root.value = val;
        root.icon = icon;
        root.title = title;
    }
}

