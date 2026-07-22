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
            "sh", "-c",
            "gamemoded -s && hyprctl eval '" +
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
            "  render = {" +
            "    direct_scanout = 1" +
            "  }" +
            "})'"
        ]
    }

    property Process gameModeDisabler: Process {
        command: ["sh", "-c", "hyprctl reload && (pkill -SIGUSR2 gamemoded || pkill gamemoded || true)"]
    }

    onActivate: {
        if (!gameModeActive) {
            gameModeActive = true;
            if (gameModeDisabler.running) gameModeDisabler.running = false;
            gameModeEnabler.running = true;
        } else {
            gameModeActive = false;
            if (gameModeEnabler.running) gameModeEnabler.running = false;
            gameModeDisabler.running = true;
        }
    }
}
