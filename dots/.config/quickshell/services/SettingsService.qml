pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type missing-type

Singleton {
    id: root

    property string settingsFilePath: Quickshell.env("HOME") + "/.config/quickshell/settings.json"
    property bool windowVisible
    property string searchText: ""

    property alias scaleFactor: displayObj.scaleFactor

    property alias general: adapter.general
    property alias display: adapter.display
    property alias appearance: adapter.appearance
    property alias bar: adapter.bar

    readonly property JsonAdapter adapter: JsonAdapter {
        id: adapter

        property JsonObject general: JsonObject {
            property string sansFontFamily: "Roboto Condensed"
            property string monoFontFamily: "GeistMono Nerd Font"
        }

        property JsonObject display: JsonObject {
            id: displayObj
            property real scaleFactor: 1.0              // 1.0, 1.25, 1.50, 2.0
        }

        property JsonObject bar: JsonObject {
            id: barObj
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

    readonly property FileView settingsFile: FileView {
        path: root.settingsFilePath
        watchChanges: true
        preload: false

        adapter: root.adapter
        onAdapterUpdated: writeAdapter()

        onLoadFailed: (error) => {
            if (error === FileViewError.FileNotFound) {
                root.settingsFile.writeAdapter();
            }
        }
    }

    function resetCategory(targetObj, defaultObj) {
        let keys = Object.keys(defaultObj);
        for (let i = 0; i < keys.length; i++) {
            let k = keys[i];
            if (k.endsWith("Changed") || k === "objectName") continue;
            if (typeof defaultObj[k] === "function") continue;

            targetObj[k] = defaultObj[k];
        }
    }

    function resetToDefaults() {
        resetCategory(root.general, SettingsDefaults.general);
        resetCategory(root.display, SettingsDefaults.display);
        resetCategory(root.appearance, SettingsDefaults.appearance);
        resetCategory(root.bar, SettingsDefaults.bar);
    }

    IpcHandler {
        target: "settings"
        function openMenu(): void {
            root.windowVisible = !root.windowVisible;
        }
    }

    Component.onCompleted: {
        settingsFile.reload();
    }
}

