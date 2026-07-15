import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: statsRoot

    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    function getUsageColor(percentage) {
        if (percentage >= 90) return Colors.error_container;
        if (percentage >= 75) return Colors.error;
        if (percentage >= 50) return Colors.on_error_container;
        return Colors.on_surface;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: Variables.dashInnerColSpacing * 2
        anchors.leftMargin: Variables.dashInnerColSpacing * 2
        spacing: Variables.dashInnerColSpacing * 2

        Text {
            id: usernameText
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Variables.defaultFontFamily
            font.pixelSize: 14
            color: Colors.on_surface
            text: SystemStatsService.username
        }

        // separator
        Rectangle {
            Layout.preferredHeight: 3
            Layout.fillWidth: true
            Layout.topMargin: Variables.dashInnerColSpacing
            Layout.bottomMargin: Variables.dashInnerColSpacing
            color: Colors.border_variant
            radius: Variables.dashInnerRadius
        }

        StatProgressBar {   // cpu stats
            function getCpuTempIcon(temp) {
                if (temp >= 90) return Icons.thermometerAlert;
                if (temp >= 75) return Icons.thermometerHigh;
                if (temp >= 60) return Icons.thermometer;
                return Icons.thermometerLow;
            }
            function getCpuTempIconColor(temp) {
                if (temp >= 90) return Colors.error_container;
                if (temp >= 75) return Colors.error;
                if (temp >= 60) return Colors.on_error_container;
                return Colors.on_surface;
            }

            title: Icons.cpu + " "
            progress: SystemStatsService.cpuUsed / 100
            leftSubText: SystemStatsService.cpuUsed + " %"
            rightIcon: getCpuTempIcon(SystemStatsService.cpuTemp)
            rightIconColor: getCpuTempIconColor(SystemStatsService.cpuTemp)
            rightSubText: SystemStatsService.cpuTemp + Icons.tempCelsius
        }

        StatProgressBar {   // ram stats
            title: Icons.ram + " "
            progress: SystemStatsService.ramTotal > 0 ? (SystemStatsService.ramUsed / SystemStatsService.ramTotal) : 0.0
            leftSubText: SystemStatsService.ramUsed + " GB / " + SystemStatsService.ramTotal + " GB"
            rightSubText: Math.floor(SystemStatsService.ramUsed / SystemStatsService.ramTotal * 100) + " %"
            rightSubTextColor: statsRoot.getUsageColor(SystemStatsService.ramUsed / SystemStatsService.ramTotal * 100)
        }

        StatProgressBar {   // disk stats
            title: Icons.database + " "
            progress: SystemStatsService.diskTotal > 0 ? (SystemStatsService.diskUsed / SystemStatsService.diskTotal) : 0.0
            leftSubText: SystemStatsService.diskUsed + " GB / " + SystemStatsService.diskTotal + " GB"
            rightSubText: Math.floor(SystemStatsService.diskUsed / SystemStatsService.diskTotal * 100) + " %"
            rightSubTextColor: statsRoot.getUsageColor(SystemStatsService.diskUsed / SystemStatsService.diskTotal * 100)
        }

        Item { Layout.fillHeight: true }        // filler
    }
}
