import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Widgets
import qs.services

// qmllint disable unqualified

ClippingRectangle {
    id: root

    property var activePlayer: MprisController.activePlayer
    property bool isPlaying: MprisController.isPlaying

    property real progress: {
        (activePlayer && activePlayer.length > 0) ? (activePlayer.position / activePlayer.length) : 0
    }

    anchors.fill: parent
    color: "transparent"
    radius: 12
    clip: true

    // background
    Image {
        id: bgMediaCover
        source: (root.activePlayer && root.activePlayer.trackArtUrl)
            ? root.activePlayer.trackArtUrl : ""
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        mipmap: true
        visible: false
    }

    MultiEffect {
        id: blurEffect
        source: bgMediaCover
        visible: bgMediaCover.source !== ""
        anchors.fill: parent
        blurEnabled: true
        blurMax: 48
        blur: 1.0
        opacity: 0.8
        contrast: 0.3
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 12

        Item {
            id: discWrapper
            Layout.preferredHeight: 110
            Layout.preferredWidth: 110

            Layout.alignment: Qt.AlignHCenter

            // progress ring
            Shape {
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 4

                ShapePath {
                    strokeColor: themePalette.activeBtnVibrant
                    strokeWidth: 2
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: 55
                        centerY: 55
                        radiusX: 53
                        radiusY: 53
                        startAngle: -90
                        sweepAngle: 360 * progress
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
                    source: (root.activePlayer && root.activePlayer.trackArtUrl)
                        ? root.activePlayer.trackArtUrl : ""
                    sourceSize: Qt.size(discMediaContainer.width, discMediaContainer.width)
                    asynchronous: true
                    mipmap: true
                }
            }
        }
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
