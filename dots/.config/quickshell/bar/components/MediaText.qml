import QtQuick
import qs.services
import qs.modules.theme

Item {
    id: root

    property string mode: SettingsService.mediaTextMode
    property int maxViewportWidth: Math.round(360 * Variables.scaleFactor)

    onModeChanged: {
        marqueeAnim.stop();
        mediaLabel.x = 0;
        mediaLabel.activeText = mediaLabel.getFormattedText(mediaLabel.displayedText);
        if (root.mode === "marquee") Qt.callLater(mediaLabel.checkMarquee);
    }

    implicitWidth: Math.min(mediaLabel.implicitWidth, maxViewportWidth)
    width: implicitWidth
    implicitHeight: mediaLabel.implicitHeight
    height: implicitHeight
    clip: true

    Text {
        id: mediaLabel

        property string displayedText: Icons.barMedia + "  No media playing"
        property string activeText: ""
        property var player: MprisController.activePlayer

        onPlayerChanged: updateDisplayText()

        anchors.verticalCenter: parent.verticalCenter
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.fontNormal
        font.weight: Variables.defaultFontWeight
        color: Colors.primary
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        text: activeText
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

        onDisplayedTextChanged: textSwapAnim.restart()

        onImplicitWidthChanged: {
            if (root.mode === "marquee") checkMarquee();
            else elideDisplayText();
        }

        onActiveTextChanged: {
            if (root.mode === "marquee") {
                Qt.callLater(checkMarquee);
            } else {
                Qt.callLater(elideDisplayText);
            }
        }

        SequentialAnimation {
            id: textSwapAnim

            NumberAnimation {
                target: mediaLabel
                property: "opacity"
                to: 0.0
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }

            ScriptAction {
                script: mediaLabel.activeText = mediaLabel.getFormattedText(mediaLabel.displayedText)
            }

            NumberAnimation {
                target: mediaLabel
                property: "opacity"
                to: 1.0
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        SequentialAnimation {
            id: marqueeAnim
            loops: Animation.Infinite

            PauseAnimation { duration: 1800 }

            NumberAnimation {
                target: mediaLabel
                property: "x"
                to: -(mediaLabel.implicitWidth - root.width)
                duration: Math.max(1000, (mediaLabel.implicitWidth - root.width) * 30)
                easing.type: Easing.Linear
            }

            PauseAnimation { duration: 1800 }

            NumberAnimation {
                target: mediaLabel
                property: "x"
                to: 0
                duration: Math.max(1000, (mediaLabel.implicitWidth - root.width) * 30)
                easing.type: Easing.Linear
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

            let actualText = artist ? (Icons.barMedia + "  " + title + " " + Icons.dot + " " + artist) : title;

            mediaLabel.displayedText = actualText
        }

        function checkMarquee() {
            mediaLabel.x = 0;
            if (SettingsService.mediaTextMode === "marquee" &&
                mediaLabel.implicitWidth > root.maxViewportWidth) {
                marqueeAnim.restart();
            } else {
                marqueeAnim.stop();
            }
        }

        function getFormattedText(fullString) {
            if (SettingsService.mediaTextMode === "elide" &&
                fullString.length > Variables.maxBarMediaChars) {
                return fullString.substring(0, Variables.maxBarMediaChars) + " ...";
            }
            return fullString;
        }

        function elideDisplayText() {
            text = mediaLabel.displayedText;
            if (text.length > Variables.maxBarMediaChars) {
                let newText = text.substring(0, Variables.maxBarMediaChars) + "...";
                mediaLabel.activeText = newText;
            }
        }
    }

    // onModeChanged: console.log("[MediaText] Mode changed to:", mode)
}
