pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type missing-type

QtObject {
    id: root

    property string settingsFilePath: Quickshell.env("HOME") + "/.config/quickshell/settings.json"

    property alias scaleFactor: displayObj.scaleFactor
    property alias mediaTextMode: barObj.mediaTextMode

    property alias display: adapter.display
    property alias appearance: adapter.appearance
    property alias bar: adapter.bar

    readonly property JsonAdapter adapter: JsonAdapter {
        id: adapter

        property JsonObject display: JsonObject {
            id: displayObj
            property real scaleFactor: 1.0
        }

        property JsonObject bar: JsonObject {
            id: barObj
            property string mediaTextMode: "marquee"
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

    Component.onCompleted: {
        settingsFile.reload();
    }
}

