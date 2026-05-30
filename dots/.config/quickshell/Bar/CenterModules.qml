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
		hoverLatencyTimer.start();
	    } else {
		hoverLatencyTimer.stop();
		backendIpcStream.sendSignal("CLOSE");
	    }
	}
    }

    // hover delay config
    Timer {
	id: hoverLatencyTimer
	interval: 700
	repeat: false
	onTriggered: {
	    // map relative local coordinates to absolute screen canvas space
	    var globalCoordinates = centerMediaPill.mapToItem(null, 0, 0);
	    var targetX = globalCoordinates.x;
	    var targetY = globalCoordinates.y + centerMediaPill.height + 12;	// 12px vertical gap

	    var formatPacket = "OPEN: " + Math.round(targetX) + "," + Math.round(targetY);
	    backendIpcStream.sendSignal(formatPacket)
	}
    }

    // persistent communication pipeline
    Process {
	id: backendIpcStream

	function sendSignal(message) {
	    running = false
	    command = ["sh", "-c", "echo '" + message + "' | nc -U /tmp/mist_dashboard.sock"]
	    running = true
	}
    }
}

