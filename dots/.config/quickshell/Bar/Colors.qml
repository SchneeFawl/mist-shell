import QtQuick

QtObject {
    id: colors

    // base bg layers:
    property color pillBackground: "#1a2121"
    property color pillBorder: "#3f4948"

    // text colors:
    property color textMain: "#dde4e3"
    property color textSub: '#b2bebe'
    property color textVibrant: "#9cf1f1"

    // state colors:
    property color activeAccent: "#80d4d5"      // indicator states
    property color inactiveAccent: "#252b2b"    // sleeping components
    property color statusVibrant: "#b3c8e9"     // media text elements
    property color activeBtnVibrant: "#004f50"
}

