import QtQuick
import Quickshell.Io

Item {
    id: statsManager

    property int cpuUsage: 0
    property double usedMemory: 0.0
    property double totalMemory: 16.0
    property int diskUsage: 0

    // ram tracker
    Process {
        id: freeCmd
        command: ["sh", "-c", "free -m | awk '/Mem:/ {print $3 \",\" $2}'"]
        running: false
        onStdoutParserChanged: {
            var parts = line.trim().split(",");
            if (parts.length >= 2) {
                statsManager.usedMemory = Math.round((parseInt(parts[0]) / 1024.0) * 10.0) / 10.0;
                statsManager.totalMemory = Math.round((parseInt(parts[1]) / 1024.0) * 10.0) / 10.0;
            }
        }
    }

    // cpu tracker
    Process {
        id: cpuCmd
        command: ["bash", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'"]
        running: false
        onStdoutParserChanged: {
            statsManager.cpuUsage = Math.round(parseFloat(line.trim()));
        }
    }

    // disk tracker
    Process {
        id: diskCmd
        command: ["sh", "-c", "df / | awk 'NR==2 {print $5}' | sed 's/%//'"]
        running: false
        onStdoutParserChanged: {
            statsManager.diskUsage = parseInt(line.trim());
        }
    }

    // central timer loop (scheduler)
    Timer {
        interval: 1700
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            freeCmd.running = true;
            cpuCmd.running = true;
            diskCmd.running = true;
        }
    }
}

