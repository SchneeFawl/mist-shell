pragma Singleton
import QtQuick
import Quickshell.Services.Mpris

Item {
    id: controllerRoot

    property var activePlayer: null
    property bool isPlaying: {
        activePlayer ? activePlayer.playbackState === MprisPlaybackState.Playing : false
    }

    // scanner to find the playing player
    function updateTrackedPlayer() {
        const list = Mpris.players.values;
        if (list.length === 0) {
            activePlayer = null;
            return;
        }

        for (let i = 0; i < list.length; i++) {
            if (list[i].playbackState === MprisPlaybackState.Playing) {
                activePlayer = list[i];
                return;
            }
        }

        activePlayer = list[0];
    }

    Instantiator {
        model: Mpris.players

        onObjectAdded: controllerRoot.updateTrackedPlayer()
        onObjectRemoved: controllerRoot.updateTrackedPlayer()

        delegate: Connections {
            target: modelData
            function onPlaybackStateChanged() {
                controllerRoot.updateTrackedPlayer();
            }
        }

        // run on start
        Component.onCompleted: controllerRoot.updateTrackedPlayer()
    }
}
