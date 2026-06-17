pragma Singleton
import QtQuick
import Quickshell.Io

// qmllint disable unresolved-type

FileView {
    id: colors
    path: Qt.resolvedUrl("./colors.json")
    watchChanges: true
    preload: true

    adapter: JsonAdapter {
        // base bg layers:
        property color background: "#101418"
        property color border: "#42474e"

        // text colors (general):
        property color textMain: "#e0e2e8"
        property color textSub: "#c2c7cf"
        property color textVibrant: "#b9c8da"

        // state colors:
        property color activeAccent: "#9bcbfb"      // indicator states
        property color inactiveAccent: "#d3bfe6"    // sleeping components
        property color activeVibrant: "#42474e"
    }
    
    property color background: adapter.background
    property color border: adapter.border

    property color textMain: adapter.textMain
    property color textSub: adapter.textSub
    property color textVibrant: adapter.textVibrant

    property color activeAccent: adapter.activeAccent
    property color inactiveAccent: adapter.inactiveAccent
    property color activeVibrant: adapter.activeVibrant
}
