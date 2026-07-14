import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: statsRoot

    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: Variables.dashInnerColSpacing * 2
        anchors.leftMargin: Variables.dashInnerColSpacing * 2
        spacing: Variables.dashInnerColSpacing

        StatProgressBar {
            title: Icons.cpu + " CPU"
            progress: SystemStatsService.cpuUsed / 100
            leftSubText: SystemStatsService.cpuUsed + " %"
            rightSubText: Icons.thermometer + " " + SystemStatsService.cpuTemp + Icons.tempCelsius
        }

        StatProgressBar {
            title: Icons.ram + " RAM"
            progress: SystemStatsService.ramUsed / SystemStatsService.ramTotal
            leftSubText: SystemStatsService.ramUsed + " / " + SystemStatsService.ramTotal + " GB"
            rightSubText: Math.floor(SystemStatsService.ramUsed / SystemStatsService.ramTotal * 100) + " %"
        }

        Item { Layout.fillHeight: true }        // filler
    }
}
