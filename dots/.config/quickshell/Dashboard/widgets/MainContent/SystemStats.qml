import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: statsRoot

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    StatProgressBar {
        title: "CPU"
        progress: SystemStatsService.cpuUsed / 100
    }
}
