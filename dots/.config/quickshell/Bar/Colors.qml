import QtQuick

QtObject {
    id: colors

    // base bg layers:
    property color pillBackground: "#1A1B26"
    property color pillBorder: "#24283B"

    // high contrast values:
    property color textMain: "#A9B1D6"
    property color textSub: "#565F89"

    // state colors
    property color activeAccent: "#7AA2F7"      // indicator states
    property color inactiveAccent: "#24283B"    // sleeping components
    property color statusVibrant: "#BB9AF7"     // media text elements
}

