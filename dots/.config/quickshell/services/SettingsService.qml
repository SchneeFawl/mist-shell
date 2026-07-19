pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type

QtObject {
    id: settingsService

    property string settingsFilePath: Quickshell.env("HOME") + "/.config/quickshell/settings.json"
    property real scaleFactor: 1.25

    property FileView settingsFile: FileView {
        path: settingsService.settingsFilePath
        watchChanges: true
        preload: false

        adapter: JsonAdapter {
            property real scaleFactor: 1.0
        }

        onLoadFailed: {
            writeAdapter();
        }

        onLoaded: {
            settingsService.scaleFactor = adapter.scaleFactor;
        }
    }

    onScaleFactorChanged: {
        settingsFile.adapter.scaleFactor = scaleFactor;
        settingsFile.writeAdapter();
    }

    Component.onCompleted: {
        settingsFile.reload();
    }
}
