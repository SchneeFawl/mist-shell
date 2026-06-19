pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

FileView {
    id: stateFile

    property var scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/theme_switcher.sh"

    path: Quickshell.env("HOME") + "/.config/mist/state.json"
    onAdapterUpdated: {
        writeAdapter();
        Quickshell.execDetached([scriptPath, theme, wallpaper, mode])       // qmllint disable unqualified
    }

    adapter: JsonAdapter {      // qmllint disable unresolved-type
        id: stateAdapter

        property string theme: "Mist"
        property string mode: "dark"
        property string wallpaper: ""
    }
}
