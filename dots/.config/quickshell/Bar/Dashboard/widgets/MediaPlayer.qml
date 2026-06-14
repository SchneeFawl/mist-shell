import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import qs.services

ClippingRectangle {
    id: root

    property var activePlayer: MprisController.activePlayer
    property bool isPlaying: MprisController.isPlaying

    anchors.fill: parent
    color: "transparent"
    radius: 12

    // background
    Image {
        id: bgMediaCover
        source: (root.activePlayer && root.activePlayer.trackArtUrl)
            ? root.activePlayer.trackArtUrl : ""
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        visible: false
        layer.enabled: true
    }

    MultiEffect {
        id: blurEffect
        source: bgMediaCover
        visible: bgMediaCover.source !== ""
        anchors.fill: bgMediaCover
        blurEnabled: true
        blurMax: 36
        blur: 1.0
    }

    // DEBUG
    // Text {
    //     anchors.centerIn: parent
    //     color: "black"
    //     text: root.activePlayer ?
    //         (root.activePlayer.identity + " | " + root.activePlayer.trackTitle + " | Art: "
    //         + (root.activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    // }
}
