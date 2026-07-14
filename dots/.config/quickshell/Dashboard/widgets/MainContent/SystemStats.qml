import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: statsRoot

    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    function getCpuTempIcon(temp) {
        if (temp >= 90) return Icons.thermometerAlert;
        if (temp >= 75) return Icons.thermometerHigh;
        if (temp >= 60) return Icons.thermometer;
        if (temp < 60) return Icons.thermometerLow;
    }

    function getCpuTempIconColor(temp) {
        if (temp >= 90) return Colors.error_container;
        if (temp >= 75) return Colors.error;
        if (temp >= 60) return Colors.on_error_container;
        if (temp < 60) return Colors.on_surface;
    }

    function getRamUsageColor(percentage) {
        if (percentage >= 90) return Colors.error_container;
        if (percentage >= 75) return Colors.error;
        if (percentage >= 50) return Colors.on_error_container;
        if (percentage < 50 || !percentage) return Colors.on_surface;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: Variables.dashInnerColSpacing * 2
        anchors.leftMargin: Variables.dashInnerColSpacing * 2
        spacing: Variables.dashInnerColSpacing

        StatProgressBar {
            title: Icons.cpu + " CPU"
            progress: SystemStatsService.cpuUsed / 100
            leftSubText: SystemStatsService.cpuUsed + " %"
            rightIcon: statsRoot.getCpuTempIcon(SystemStatsService.cpuTemp)
            rightIconColor: statsRoot.getCpuTempIconColor(SystemStatsService.cpuTemp)
            rightSubText: SystemStatsService.cpuTemp + Icons.tempCelsius
        }

        StatProgressBar {
            title: Icons.ram + " RAM"
            progress: SystemStatsService.ramUsed / SystemStatsService.ramTotal
            leftSubText: SystemStatsService.ramUsed + " / " + SystemStatsService.ramTotal + " GB"
            rightSubText: Math.floor(SystemStatsService.ramUsed / SystemStatsService.ramTotal * 100) + " %"
            rightSubTextColor: statsRoot.getRamUsageColor(SystemStatsService.ramUsed / SystemStatsService.ramTotal * 100)
        }

        Item { Layout.fillHeight: true }        // filler
    }
}
