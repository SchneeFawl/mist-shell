pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type 

QtObject {
    id: root

    property var scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/theme_switcher.sh"
    property var scanScriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/generate_themes.py"

    property var stateFilePath: Quickshell.env("HOME") + "/.config/mist/state.json"
    property var themesFilePath: Quickshell.env("HOME") + "/.config/mist/themes.json"

    property string theme: "Mist"
    property string wallpaper: ""
    property string mode: "dark"

    readonly property var themeList: themesFile.adapter.themes
    readonly property bool isScanning: themeScanner.running

    property FileView stateFile: FileView {
        path: root.stateFilePath
        watchChanges: true
        preload: true

        adapter: JsonAdapter {
            id: stateAdapter
            property string theme: "Mist"
            property string wallpaper: ""
            property string mode: "dark"
        }

        onAdapterUpdated: {
            if (root.theme !== adapter.theme ||
                root.wallpaper !== adapter.wallpaper ||
                root.mode !== adapter.mode ) {

                root.theme = root.stateFile.adapter.theme;
                root.wallpaper = root.stateFile.adapter.wallpaper;
                root.mode = root.stateFile.adapter.mode;

                Quickshell.execDetached([root.scriptPath, root.theme, root.wallpaper, root.mode])
            }
        }
    }

    function updateState(newTheme, newWallpaper, newMode) {
        root.theme = newTheme;
        root.wallpaper = newWallpaper;
        root.mode = newMode;

        root.stateFile.adapter.theme = newTheme;
        root.stateFile.adapter.wallpaper = newWallpaper;
        root.stateFile.adapter.mode = newMode;

        stateFile.writeAdapter();

        Quickshell.execDetached([root.scriptPath, newTheme, newWallpaper, newMode])
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
