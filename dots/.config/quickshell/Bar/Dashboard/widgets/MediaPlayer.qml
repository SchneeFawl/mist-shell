import QtQuick
import QtQuick.Effects
import qs.services

Rectangle {
    id: root

    property var activePlayer: MprisController.activePlayer
    property bool isPlaying: MprisController.isPlaying

    anchors.fill: parent
    color: "transparent"
    radius: 12
    clip: true
    layer.enabled: true

    Image {
        id: bgMediaCover
        source: (root.activePlayer && root.activePlayer.trackArtUrl)
            ? root.activePlayer.trackArtUrl : ""
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    MultiEffect {
        id: blurEffect
        source: bgMediaCover
        visible: bgMediaCover.source !== ""
        anchors.fill: parent
        blurEnabled: true
        blurMax: 36
        blur: 1.0
    }

    // DEBUG
    Text {
        anchors.centerIn: parent
        color: "black"
        text: root.activePlayer ?
            (root.activePlayer.identity + " | " + root.activePlayer.trackTitle + " | Art: "
            + (root.activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    }
}
