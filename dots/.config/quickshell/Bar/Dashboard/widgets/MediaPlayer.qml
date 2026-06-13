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
        anchors.fill: parent
        source: (root.activePlayer && root.activePlayer.trackArtUrl) ? root.activePlayer.trackArtUrl : ""
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

    Text {
        anchors.centerIn: parent
        color: "black"
        text: root.activePlayer ?
            (root.activePlayer.identity + " | " + root.activePlayer.trackTitle + " | Art: "
            + (root.activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    }
}
