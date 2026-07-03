pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: gameModeRoot

    property bool gameModeActive: false
    signal activate()

    property Process gameModeEnabler: Process {
        command: [
            "hyprctl",
            "eval",
            "hl.config({" +
            "  decoration = {" +
            "    rounding = 0," +
            "    rounding_power = 0," +
            "    shadow = { enabled = false }," +
            "    blur = { enabled = false }," +
            "  }," +
            "  animations = { enabled = false }," +
            "  general = {" +
            "    gaps_in = 0," +
            "    gaps_out = 0," +
            "    border_size = 1," +
            "    allow_tearing = true" +
            "  }," +
            "})"
        ]
    }

    property Process gameModeDisabler: Process {
        command: ["hyprctl", "reload"]
    }

    onActivate: {
        if (!gameModeActive) {
            gameModeActive = true;
            gameModeEnabler.startDetached();
        } else {
            gameModeActive = false;
            gameModeDisabler.startDetached();
        }
    }
}
