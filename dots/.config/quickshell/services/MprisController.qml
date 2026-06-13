pragma Singleton
import QtQuick
import Quickshell.Services.Mpris

// qmllint disable unqualified

Item {

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

        onObjectAdded: updateTrackedPlayer()
        onObjectRemoved: updateTrackedPlayer()

        delegate: Connections {
            target: modelData
            function onPlaybackStateChanged() {
                updateTrackedPlayer();
            }
        }

        // run on start
        Component.onCompleted: updateTrackedPlayer()
    }
}
