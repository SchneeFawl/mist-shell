pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type unqualified

QtObject {
    id: root

    property var scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/theme_switcher.sh"
    property var scanScriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/generate_themes.py"

    property var stateFilePath: Quickshell.env("HOME") + "/.config/mist/state.json"
    property var themesFilePath: Quickshell.env("HOME") + "/.config/mist/themes.json"

    property alias theme: stateAdapter.theme
    property alias wallpaper: stateAdapter.wallpaper
    property alias mode: stateAdapter.mode

    property FileView stateFile: FileView {
        path: root.stateFilePath
        onAdapterUpdated: {
            writeAdapter();
            Quickshell.execDetached([root.scriptPath, stateAdapter.theme, stateAdapter.wallpaper, stateAdapter.mode])
        }

        adapter: JsonAdapter {
            id: stateAdapter
            property string theme: "Mist"
            property string wallpaper: ""
            property string mode: "dark"
        }
    }

    property FileView themesFile: FileView {
        path: root.themesFilePath
        watchChanges: true
        preload: true

        adapter: JsonAdapter {
            id: themesAdapter
            property var themes: []
        }
    }

    property Process themeScanner: Process {
        command: ["python3", root.scanScriptPath]
        running: true           // run on startup
    }

    function rescanThemes() {
        if (!root.themeScanner.running) {
            themeScanner.exec()
        }
    }
}
