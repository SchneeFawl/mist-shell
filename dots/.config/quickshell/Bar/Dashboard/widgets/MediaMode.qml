import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris

// qmllint disable unqualified

Rectangle {
    id: mediaRectRoot

    property var activePlayer: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    property bool isPlaying: activePlayer ? activePlayer.playbackState === MprisPlaybackState.Playing : false

    anchors.fill: parent
    color: "transparent"
    radius: 12

    Text {
        anchors.centerIn: parent
        color: "black"
        text: activePlayer ? (activePlayer.identity + " | " + activePlayer.trackTitle + " | Art: " + (activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    }

    Image {
        id: bgMediaCover
        anchors.fill: parent
        source: (activePlayer && activePlayer.trackArtUrl) ? activePlayer.trackArtUrl : ""
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    MultiEffect {
        id: bgMediaBlurred
        anchors.fill: parent
        source: bgMediaCover
        blurEnabled: true
        blurMax: 32
        blur: 1.0
        opacity: 1
        visible: bgMediaCover.source !== ""
    }
}

