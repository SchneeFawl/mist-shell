import QtQuick
import Quickshell.Io

Item {
    id: statsManager

    property int cpuUsage: 0
    property double usedMemory: 0.0

    // ram tracker
    Process {
        id: freeCmd
        command: ["sh", "-c", "free -g | awk '/Mem:/ {print $3}'"]
        running: false
        onStdoutParserChanged: {
            statsManager.usedMemory = parseFloat(line.trim())
        }
    }

    // cpu tracker
    Process {
        id: cpuCmd
        command: ["bash", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'"]
        running: false
        onStdoutParserChanged: {
            statsManager.cpuUsage = Math.round(parseFloat(line.trim()))
        }
    }

    // central timer loop (schedulerr)
    Timer {
        interval: 1700
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            freeCmd.running: true
            cpuCmd.running: true
        }
    }
}
