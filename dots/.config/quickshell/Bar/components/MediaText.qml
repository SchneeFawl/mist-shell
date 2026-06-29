import QtQuick
import qs.services
import qs.modules.theme

Text {
    id: mediaLabel

    property string displayedText: Icons.barMedia + "  No media playing"
    property string activeText: ""
    property var player: MprisController.activePlayer

    onPlayerChanged: updateDisplayText()

    font.family: Variables.defaultFontFamily
    font.pixelSize: 13
    font.weight: Variables.defaultFontWeight
    color: Colors.primary
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    opacity: 1.0

    Connections {
        target: mediaLabel.player
        ignoreUnknownSignals: true

        function onTrackTitleChanged() {
            mediaLabel.updateDisplayText();
        }

        function onTrackArtistChanged() {
            mediaLabel.updateDisplayText();
        }
    }

    Timer {
        id: resetTimer
        interval: 1000
        repeat: false
        onTriggered: {
            if (!mediaLabel.player) {
                mediaLabel.displayedText = Icons.barMedia + "  No media playing";
            }
        }
    }

    function updateDisplayText() {
        let active = MprisController.activePlayer

        if (!active) {
            resetTimer.start();
            return;
        }

        resetTimer.stop();

        let title = active.trackTitle
        let artist = active.trackArtist

        // in case no title, display identity
        if (!title || title.trim() === "") {
            if (displayedText !== Icons.barMedia + "  No media playing") return;

            let name = active.identity ?? "Media";
            displayedText = Icons.barMedia + "  " + name;
            return;
        }

        let actualText = artist ? (title + " " + Icons.dot + " " + artist) : title;
        let maxChars = Variables.maxBarMediaChars

        if (actualText.length() > maxChars) {
            actualText = actualText.substring(0, maxChars) + " ...";
        }

        mediaLabel.displayedText = actualText
    }
}
