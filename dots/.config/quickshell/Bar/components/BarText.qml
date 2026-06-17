import QtQuick
import qs.modules.theme
import qs.services

Text {
    id: label

    property bool isSubText: false
    property string displayedText: Icons.barMedia + "  No media playing"
    property string activeText: ""
    property var player: MprisController.activePlayer

    onPlayerChanged: updateDisplayText()

    font.family: Variables.defaultFontFamily
    font.pixelSize: isSubText ? 11 : 13
    font.weight: isSubText ? Variables.defaultFontWeight - 100 : Variables.defaultFontWeight
    color: isSubText ? Colors.textSub : Colors.textMain
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    opacity: 1.0

    Timer {
        id: resetTimer
        interval: 1000
        repeat: false
        onTriggered: {
            if (!label.player) {
                label.displayedText = Icons.barMedia + "  No media playing";
            }
        }
    }

    Connections {
        target: MprisController.activePlayer
        ignoreUnknownSignals: true      // ignore warnings if null

        function onTrackTitleChanged() {
            label.updateDisplayText()
        }

        function onTrackArtistChanged() {
            label.updateDisplayText()
        }
    }

    function updateDisplayText() {
        let active = MprisController.activePlayer

        if (!active) {
            resetTimer.start();
            return;
        }

        resetTimer.stop();
        
        let title = active.trackTitle;
        let artist = active.trackArtist;

        if (!title || title.trim() === "") {
            if (displayedText !== Icons.barMedia + "  No media playing") return;

            let name = active.identity ? active.identity : "Media";
            displayedText = Icons.barMedia + "  " + name;
            return;
        }

        let actualText = artist ? (title + " - " + artist) : title;
        let maxChars = Variables.maxBarMediaChars;
        
        if (actualText.length > maxChars) {
            actualText = actualText.substring(0, maxChars) + "...";
        }

        label.displayedText = Icons.barMedia + "  " + actualText;
    }
}
