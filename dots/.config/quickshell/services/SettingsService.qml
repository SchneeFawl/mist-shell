pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type

QtObject {
    id: settingsService

    property string settingsFilePath: Quickshell.env("HOME") + "/.config/quickshell/settings.json"

    // all the settings:
    property real scaleFactor: 1.25
    property string mediaTextMode: "marquee"        // OPTIONS: "marquee", "elide"

    property FileView settingsFile: FileView {
        path: settingsService.settingsFilePath
        watchChanges: true
        preload: false

        adapter: JsonAdapter {
            property real scaleFactor: 1.0
            property string mediaTextMode: "marquee"
        }

        onLoadFailed: {
            writeAdapter();
        }

        onLoaded: {
            settingsService.scaleFactor = adapter.scaleFactor;
            settingsService.mediaTextMode = adapter.mediaTextMode;
        }
    }

    onScaleFactorChanged: {
        settingsFile.adapter.scaleFactor = scaleFactor;
        settingsFile.adapter.mediaTextMode = mediaTextMode;
        settingsFile.writeAdapter();
    }

    Component.onCompleted: {
        settingsFile.reload();
    }
}

