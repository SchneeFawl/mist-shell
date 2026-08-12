pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property JsonObject general: JsonObject {
        property string sansFontFamily: "Roboto Condensed"
        property string monoFontFamily: "GeistMono Nerd Font"
    }

    property JsonObject display: JsonObject {
        property real scaleFactor: 1.0              // 1.0, 1.25, 1.50, 2.0
    }

    property JsonObject bar: JsonObject {
        property string position: "top"             // top, bottom, vertical-left, vertical-right
        property string style: "fragmented"         // fragmented, filled
        property string mediaTextMode: "marquee"    // marquee, elide
    }

    property JsonObject appearance: JsonObject {
        property real radiusMultiplier: 1.0
        property real spacingMultiplier: 1.0
        property real fontSizeMultiplier: 1.0
    }
}

