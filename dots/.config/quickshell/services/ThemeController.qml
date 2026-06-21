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

    property bool keyboardFocus: false

    readonly property var themeList: themesFile.adapter.themes
    readonly property bool isScanning: themeScanner.running

    onThemeChanged: stateFile.writeAdapter()
    onWallpaperChanged: stateFile.writeAdapter()
    onModeChanged: {
        stateFile.writeAdapter();
    }

    Component.onCompleted: {
        stateFile.reload();
    }

    property FileView stateFile: FileView {
        path: root.stateFilePath
        watchChanges: true
        preload: false

        adapter: JsonAdapter {
            id: stateAdapter
            property string theme: "Mist"
            property string wallpaper: ""
            property string mode: "dark"
        }

        onLoaded: {
            root.theme = root.stateFile.adapter.theme;
            root.wallpaper = root.stateFile.adapter.wallpaper;
            root.mode = root.stateFile.adapter.mode;

            // DEBUG
            console.log("[ThemeController] state.json sync complete")
            console.log("[ThemeController] Active state: theme=" + root.theme + ", wallpaper=" + root.wallpaper + ", mode=" + root.mode)
        }

        onLoadFailed: {
            console.log("[ThemeController] Failed to load state.json");
        }
    }

    function updateState(newTheme, newWallpaper, newMode) {
        let changed = (
            root.theme !== newTheme || root.wallpaper !== newWallpaper || root.mode !== newMode
        );

        root.theme = newTheme;
        root.wallpaper = newWallpaper;
        root.mode = newMode;

        root.stateFile.adapter.theme = newTheme;
        root.stateFile.adapter.wallpaper = newWallpaper;
        root.stateFile.adapter.mode = newMode;

        if (changed) {
            stateFile.writeAdapter();
            Quickshell.execDetached([scriptPath, newTheme, newWallpaper, newMode])
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
