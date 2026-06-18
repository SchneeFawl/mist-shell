pragma Singleton
import QtQuick
import Quickshell.Io

// qmllint disable unresolved-type

FileView {
    id: colors
    path: Qt.resolvedUrl("./colors.json")
    watchChanges: true
    preload: true
    onFileChanged: {
        reload();
    }

    adapter: JsonAdapter {
        // base bg layers:
        property color background: "#101418"
        property color border: "#42474e"

        // text colors (general):
        property color textMain: "#9bcbfb"
        property color textSub: "#b9c8da"
        property color textVibrant: "#cee5ff"

        // state colors:
        property color activeAccent: "#9bcbfb"      // indicator states
        property color inactiveAccent: "#d3bfe6"    // sleeping components
        property color activeVibrant: "#42474e"

        // m3 colors
        property color primary: "#9bcbfb"
        property color on_primary: "#003353"
        property color primary_container: "#0e4a73"
        property color on_primary_container: "#cee5ff"

        property color secondary: "#b9c8da"
        property color on_secondary: "#233240"
        property color secondary_container: "#3a4857"
        property color on_secondary_container: "#d5e4f7"

        property color tertiary: "#d3bfe6"
        property color on_tertiary: "#382a49"
        property color tertiary_container: "#504061"
        property color on_tertiary_container: "#eedbff"
    }

    property color background: adapter.background
    property color border: adapter.border

    property color textMain: adapter.textMain
    property color textSub: adapter.textSub
    property color textVibrant: adapter.textVibrant

    property color activeAccent: adapter.activeAccent
    property color inactiveAccent: adapter.inactiveAccent
    property color activeVibrant: adapter.activeVibrant

    property color primary: adapter.primary
    property color on_primary: adapter.on_primary
    property color primary_container: adapter.primary_container
    property color on_primary_container: adapter.on_primary_container

    property color secondary: adapter.secondary
    property color on_secondary: adapter.on_secondary
    property color secondary_container: adapter.secondary_container
    property color on_secondary_container: adapter.on_secondary_container

    property color tertiary: adapter.tertiary
    property color on_tertiary: adapter.on_tertiary
    property color tertiary_container: adapter.tertiary_container
    property color on_tertiary_container: adapter.on_tertiary_container
}
