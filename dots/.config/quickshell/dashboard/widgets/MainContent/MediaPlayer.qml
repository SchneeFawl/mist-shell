
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.services
import qs.modules.theme
import qs.modules.common
import "../../components"

ClippingRectangle {
    id: player

    readonly property var activePlayer: MprisController.activePlayer
    readonly property bool isPlaying: MprisController.isPlaying
    property var mediaCover: (activePlayer && activePlayer.trackArtUrl) ? activePlayer.trackArtUrl : ""

    property real progress: 0
    property real currentPosition: 0
    onActivePlayerChanged: {
        currentPosition = activePlayer?.position ?? 0;
        progress = (activePlayer && activePlayer.length > 0) ? (currentPosition / activePlayer.length) : 0;
    }

    // anchors.fill: parent
    color: blurEffect.visible ? "transparent" : Colors.surface_container_low
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
        brightness: -0.075
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.spacingMedium
        spacing: Variables.spacingNormal - Math.round(2 * Variables.scaleFactor)

        // wrapper for disc + progress ring
        Item {
            id: discWrapper
            Layout.preferredHeight: discMediaContainer.height + Math.round(20 * Variables.scaleFactor)
            Layout.preferredWidth: discMediaContainer.width + Math.round(20 * Variables.scaleFactor)
            Layout.alignment: Qt.AlignHCenter

            // progress ring
            Shape {
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 8

                ShapePath {
                    id: discPath
                    strokeColor: Colors.primary
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
                height: Math.round(120 * Variables.scaleFactor)
                width: Math.round(120 * Variables.scaleFactor)
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
            spacing: Variables.spacingSmall
            Layout.leftMargin: Variables.spacingMedium
            Layout.rightMargin: Variables.spacingMedium

            StyledText {
                id: songProgress
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Variables.fontSmall
                color: Colors.secondary
                text: {
                    player.activePlayer ?
                    (formatTime(player.currentPosition) + " / " + formatTime(player.activePlayer.length)) : "--:--"
                }

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

            StyledText {
                id: songTitle
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pixelSize: Variables.fontMedium
                color: Colors.on_primary_container
                text: player.activePlayer?.trackTitle ?? "No media playing"
                elide: Text.ElideRight
            }

            StyledText {
                id: artistName
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: Colors.tertiary
                text: player.activePlayer?.trackArtist ?? "-"
                elide: Text.ElideRight
            }
        }

        RowLayout {
            id: playbackControls
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: Variables.spacingNormal
            Layout.rightMargin: Variables.spacingNormal
            Layout.bottomMargin: Variables.spacingMedium
            Layout.alignment: Qt.AlignHCenter
            spacing: Variables.spacingNormal

            // previous btn
            MediaControlBtn {
                icon: Icons.mediaPrevious
                iconColor: Colors.primary_fixed
                btnSize: Variables.buttonHeight
                onClicked: player.activePlayer.canGoPrevious ? player.activePlayer.previous() : null
            }

            // play/pause btn
            MediaControlBtn {
                icon: player.isPlaying ? Icons.mediaPause : Icons.mediaPlay
                iconSize: Variables.iconLargest + Math.round(4 * Variables.scaleFactor)
                btnSize: Variables.buttonHeight + Math.round(24 * Variables.scaleFactor)
                bgColor: Colors.primary
                iconColor: Colors.on_primary
                onClicked: {
                    if (player.activePlayer && player.isPlaying) {
                        player.activePlayer.pause();
                    } else {
                        player.activePlayer.play();
                    }
                }
            }

            // next btn
            MediaControlBtn {
                icon: Icons.mediaNext
                iconColor: Colors.primary_fixed
                btnSize: Variables.buttonHeight
                onClicked: player.activePlayer.canGoNext ? player.activePlayer.next() : null
            }

            // loop btn
            MediaControlBtn {
                iconSize: Variables.iconLargest
                icon: {
                    if (!player.activePlayer) return Icons.mediaLoopNone;
                    switch (player.activePlayer.loopState) {
                        case MprisLoopState.Playlist: return Icons.mediaLoopPlaylist;
                        case MprisLoopState.Track: return Icons.mediaLoopTrack;
                        default: return Icons.mediaLoopNone;
                    }
                }
                iconColor: Colors.primary_fixed
                btnSize: Variables.buttonHeight

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
        running: player.activePlayer && player.isPlaying && player.visible
        onTriggered: {
            let active = player.activePlayer;

            if (active && Mpris.players.values.includes(active) && active.length > 0) {
                // 33ms = 0.033s
                player.currentPosition = Math.min(player.currentPosition + 0.033, active.length)
                player.progress = player.currentPosition / active.length;
            } else {
                player.progress = 0;
            }
        }
    }

    Connections {
        target: Time
        enabled: player.activePlayer && player.isPlaying

        function onTick() {
            let active = player.activePlayer
            if (!active) return;

            // sync if paused or skipped seconds
            if (!player.isPlaying || Math.abs(active.position - player.currentPosition) > 2.0) {
                player.currentPosition = active.position;
            }

            // if (active && Mpris.players.values.includes(active)) {
            //     if (active.position !== undefined) {
            //         player.currentPosition = active.position;
            //     }
            // }
        }
    }
}
