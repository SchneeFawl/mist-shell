import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Widgets
import qs.services

// qmllint disable unqualified

ClippingRectangle {
    id: player

    property var activePlayer: MprisController.activePlayer
    property bool isPlaying: MprisController.isPlaying
    property var mediaCover: (activePlayer && activePlayer.trackArtUrl) ? activePlayer.trackArtUrl : ""

    property real progress: (activePlayer && activePlayer.length > 0) ? (activePlayer.position / activePlayer.length) : 0

    anchors.fill: parent
    color: "transparent"
    radius: 12
    clip: true

    // background
    Image {
        id: bgMediaCover
        source: player.mediaCover
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        mipmap: true
        visible: false
    }

    MultiEffect {
        id: blurEffect
        source: bgMediaCover
        visible: player.mediaCover !== ""
        anchors.fill: parent
        blurEnabled: true
        blurMax: 48
        blur: 1.0
        opacity: 0.8
        contrast: 0.3
        brightness: -0.175
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 12

        // wrapper for disc + progress ring
        Item {
            id: discWrapper
            Layout.preferredHeight: 120
            Layout.preferredWidth: 120
            Layout.alignment: Qt.AlignHCenter
            visible: player.mediaCover !== ""

            // progress ring
            Shape {
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 8

                ShapePath {
                    id: discPath
                    strokeColor: themePalette.statusVibrant
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: discWrapper.width / 2
                        centerY: discWrapper.width / 2
                        radiusX: (discWrapper.width / 2) - discPath.strokeWidth
                        radiusY: (discWrapper.width / 2) - discPath.strokeWidth
                        startAngle: -90         // 0 degrees = 3 o'clock
                        sweepAngle: 360 * player.progress
                    }
                }
            }

            // cover art container
            ClippingRectangle {
                id: discMediaContainer
                anchors.centerIn: parent
                height: 100
                width: 100
                radius: width / 2

                Image {
                    id: coverArt
                    anchors.centerIn: parent
                    source: player.mediaCover
                    sourceSize: Qt.size(discMediaContainer.width, discMediaContainer.width)
                    asynchronous: true
                    mipmap: true
                }
            }
        }
    }

    Timer {
        id: progressTimer
        interval: 30            // 30 fps
        repeat: true
        running: player.activePlayer && player.isPlaying
        onTriggered: {
            if (player.activePlayer && player.activePlayer.length > 0) {
                progress = player.activePlayer.position / player.activePlayer.length;
            } else {
                progress = 0
            }
        }
    }

    // DEBUG
    // Text {
    //     anchors.centerIn: parent
    //     color: "yellow"
    //     text: player.activePlayer ?
    //         (player.activePlayer.identity + " | " + player.activePlayer.trackTitle + " | Art: "
    //         + (player.activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    // }
}
