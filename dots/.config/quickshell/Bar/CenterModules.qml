import QtQuick
import Quickshell.Io

Pill {
    id: centerMediaPill

    property bool holdsTargetPointer: false

    Text {
        anchors.centerIn: parent
        text: "󰕮  System Center"
        color: "#cdd6f4"
        font.pixelSize: 14
    }

    MouseArea {
	id: interactionCanvas
	anchors.fill: parent
	hoverEnabled: true

	onContainsMouseChanged: {
	    if (containsMouse) {
		closeGraceTimer.stop();
		hoverLatencyTimer.start();
	    } else {
		hoverLatencyTimer.stop();
		closeGraceTimer.start();
	    }
	}
    }

    // grace period window: allows the cursor to safely traverse teh gap b/w bar and widget
    Timer {
	id: closeGraceTimer
	interval: 1000
	repeat: false
	onTriggered: {
	    backendIpcStream.sendSignal("CLOSE");
	}
    }

    // hover delay config
    Timer {
	id: hoverLatencyTimer
	interval: 800
	repeat: false
	onTriggered: {
	    // map relative local coordinates to absolute screen canvas space
	    var globalCoordinates = centerMediaPill.mapToItem(null, 0, 0);
	    var targetX = globalCoordinates.x;
	    var targetY = globalCoordinates.y + centerMediaPill.height + 6;	// 6px vertical gap from the pill

	    var formatPacket = "OPEN: " + Math.round(targetX) + "," + Math.round(targetY) + "," + Math.round(centerMediaPill.width);
	    backendIpcStream.sendSignal(formatPacket)
	}
    }

    // persistent communication pipeline
    Process {
	id: backendIpcStream

	function sendSignal(message) {
	    running = false
	    command = ["sh", "-c", "echo '" + message + "' | nc -U -N /tmp/mist_dashboard.sock"]
	    running = true
	}
    }
}

