pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    readonly property real maxValue: 2.0

    property real sinkValue: sink?.audio?.volume ?? 0
    property bool sinkMuted: sink?.audio?.muted

    property real sourceValue: source?.audio?.volume ?? 0
    property bool sourceMuted: source?.audio?.muted

    PwObjectTracker {
        objects: [ root.sink, root.source ]
    }
}
