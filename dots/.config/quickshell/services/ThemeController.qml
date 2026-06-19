pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unqualified

FileView {
    id: stateFile

    property var scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/theme_switcher.sh"

    path: Quickshell.env("HOME") + "/.config/mist/state.json"
    onAdapterUpdated: {
        writeAdapter();
        Quickshell.execDetached([scriptPath, stateAdapter.theme, stateAdapter.wallpaper, stateAdapter.mode])
    }

    adapter: JsonAdapter {      // qmllint disable unresolved-type
        id: stateAdapter

        property string theme: "Mist"
        property string mode: "dark"
        property string wallpaper: ""
    }
}
