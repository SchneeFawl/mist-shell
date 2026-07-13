pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: sysStatsRoot

    property string scripPath: Quickshell.env("HOME") + "/.config/mist/scripts/system_stats.sh"

    property string username: ""
    property string hostname: ""
    property string os: ""
    property var cpuUsed: 0
    property var cpuTemp: 0
    property var ramUsed: 0
    property var ramTotal: 0
    property var diskUsed: 0
    property var diskTotal: 0

    Process {
        running: true
        command: ["bash", sysStatsRoot.scripPath]
        stdout: SplitParser {
            onRead: (data) => {
                try {
                    let line = JSON.parse(data)

                    sysStatsRoot.username = line.username;
                    sysStatsRoot.hostname = line.hostname;
                    sysStatsRoot.os = line.os;
                    sysStatsRoot.cpuUsed = line.cpu;
                    sysStatsRoot.cpuTemp = line.temp;
                    sysStatsRoot.ramUsed = line.ram_used;
                    sysStatsRoot.ramTotal = line.ram_total;
                    sysStatsRoot.diskUsed = line.disk_used;
                    sysStatsRoot.diskTotal = line.disk_total;
                } catch(error) {
                    console.log("[SystemStatsService] Error occurred:", error)
                }
            }
        }
    }

    // Component.onCompleted: console.log("[SystemStatsService] Initialized successfully")
}
