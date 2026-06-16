import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.services
import qs.modules.theme
import "../components"

// qmllint disable unqualified

ClippingRectangle {
    id: player

    readonly property var activePlayer: MprisController.activePlayer
    readonly property bool isPlaying: MprisController.isPlaying
    property var mediaCover: (activePlayer && activePlayer.trackArtUrl) ? activePlayer.trackArtUrl : ""

    property real progress: 0
    onActivePlayerChanged: progress = 0

    anchors.fill: parent
    color: blurEffect.visible ? "transparent" : Colors.pillBorder
    radius: Variables.dashColumnRadius
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
        contrast: 0.05
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 6

        // wrapper for disc + progress ring
        Item {
            id: discWrapper
            Layout.preferredHeight: discMediaContainer.height + 20
            Layout.preferredWidth: discMediaContainer.width + 20
            Layout.alignment: Qt.AlignHCenter

            // progress ring
            Shape {
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 8

                ShapePath {
                    id: discPath
                    strokeColor: Colors.statusVibrant
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
                height: 120
                width: 120
                radius: width / 2
                color: "transparent"

                Image {
                    id: coverArt
                    anchors.centerIn: parent
                    source: player.mediaCover
                    sourceSize: Qt.size(discMediaContainer.width, discMediaContainer.width)
                    asynchronous: true
                    mipmap: true
                }

                NumberAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 15000
                    loops: Animation.Infinite
                    running: player.activePlayer?.playbackState === MprisPlaybackState.Playing
                }
            }
        }

        ColumnLayout {
            id: trackDetails
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 3
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Text {
                id: songProgress
                text: player.activePlayer ?
                    (formatTime(player.activePlayer.position) + " / " + formatTime(player.activePlayer.length))
                    : "--:--"
                color: Colors.mediaPlayerDim
                font.pixelSize: 10
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter

                // helper func to format media length into mins and secs
                function formatTime(seconds) {
                    const totalSeconds = Math.floor(seconds);
                    const hours = Math.floor(totalSeconds / 3600);
                    const mins = Math.floor((totalSeconds % 3600) / 60);
                    const secs = totalSeconds % 60;

                    if (hours > 0) {
                        return hours + ":" + (mins < 10 ? "0" : "") + mins + ":" + (secs < 10 ? "0" : "") + secs;
                    } else {
                        return mins + ":" + (secs < 10 ? "0" : "") + secs;
                    }
                }
            }

            Text {
                id: songTitle
                text: player.activePlayer ? player.activePlayer.trackTitle : "No media playing"
                color: Colors.mediaPlayerTitle
                font.bold: true
                font.pixelSize: 18
                elide: Text.ElideRight
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: artistName
                text: player.activePlayer ? player.activePlayer.trackArtist : "-"
                color: Colors.mediaPlayerArtist
                font.pixelSize: 13
                elide: Text.ElideRight
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout {
            id: playbackControls
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.bottomMargin: 12
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            MediaControlBtn {       // previous btn
                icon: Icons.mediaPrevious
                iconColor: Colors.textMain
                btnSize: 40
                onClicked: player.activePlayer.previous()
            }

            MediaControlBtn {       // play/pause btn
                icon: player.isPlaying ? Icons.mediaPause : Icons.mediaPlay
                iconSize: 32 + btnSize - 50
                btnSize: 58
                bgColor: Colors.activeAccent
                iconColor: Colors.inactiveAccent
                onClicked: {
                    if (player.activePlayer && player.isPlaying) {
                        player.activePlayer.pause();
                    } else {
                        player.activePlayer.play();
                    }
                }
            }

            MediaControlBtn {       // next btn
                icon: Icons.mediaNext
                iconColor: Colors.textMain
                btnSize: 40
                onClicked: player.activePlayer.next()
            }

            MediaControlBtn {       // loop btn
                icon: {
                    if (!player.activePlayer) return Icons.mediaLoopNone;
                    switch (player.activePlayer.loopState) {
                        case MprisLoopState.Playlist: return Icons.mediaLoopPlaylist
                        case MprisLoopState.Track: return Icons.mediaLoopTrack
                        default: return Icons.mediaLoopNone
                    }
                }
                iconColor: Colors.textMain
                btnSize: 40

                onClicked: {
                    if (player.activePlayer && player.activePlayer.loopSupported && player.activePlayer.loopState === MprisLoopState.None) {
                        player.activePlayer.loopState = MprisLoopState.Playlist;
                    } else if (player.activePlayer.loopState === MprisLoopState.Playlist) {
                        player.activePlayer.loopState = MprisLoopState.Track;
                    } else if (player.activePlayer.loopState === MprisLoopState.Track) {
                        player.activePlayer.loopState = MprisLoopState.None;
                    } else {
                        player.activePlayer.loopState = MprisLoopState.None;
                    }
                }
            }
        }
    }

    Timer {
        id: progressTimer
        interval: 33            // 1000 / 33.33 = ~30 fps
        repeat: true
        running: player.activePlayer && player.isPlaying
        onTriggered: {
            let active = player.activePlayer;

            if (active && Mpris.players.values.includes(active) && active.length > 0) {
                progress = active.position / active.length;
            } else {
                progress = 0;
            }
        }
    }

    Timer {
        id: lengthTimer
        interval: 1000
        running: player.activePlayer && player.isPlaying
        repeat: true
        onTriggered: {
            let active = player.activePlayer

            if (active && Mpris.players.values.includes(active)) {
                player.activePlayer.positionChanged();
            }
        }
    }

    // DEBUG:
    // Text {
    //     anchors.centerIn: parent
    //     color: "yellow"
    //     text: player.activePlayer ?
    //         (player.activePlayer.identity + " | " + player.activePlayer.trackTitle + " | Art: "
    //         + (player.activePlayer.trackArtUrl ? "yes" : "no")) : "no active player"
    // }
}
