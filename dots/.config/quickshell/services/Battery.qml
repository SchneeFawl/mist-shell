pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.modules.theme

Singleton {
    id: batteryRoot

    property bool hasBattery: UPower.displayDevice.isLaptopBattery
    property real batPercentage: UPower.displayDevice.percentage * 100
    property bool state: UPower.displayDevice.state
    property bool isCharging: state === UPowerDeviceState.Charging
    property real chargingTime: UPower.displayDevice.timeToFull
    property real emptyTime: UPower.displayDevice.timeToEmpty

    function getBatteryIcon(percentage) {
        if (percentage === 100) return Icons.batteryFull;
        if (percentage < 10) return Icons.batteryAlert;
        if (percentage >= 10 && percentage < 20) return Icons.battery10;
        if (percentage >= 20 && percentage < 30) return Icons.battery20;
        if (percentage >= 30 && percentage < 40) return Icons.battery30;
        if (percentage >= 40 && percentage < 50) return Icons.battery40;
        if (percentage >= 50 && percentage < 60) return Icons.battery50;
        if (percentage >= 60 && percentage < 70) return Icons.battery60;
        if (percentage >= 70 && percentage < 80) return Icons.battery70;
        if (percentage >= 80 && percentage < 90) return Icons.battery80;
        if (percentage >= 90 && percentage < 100) return Icons.battery90;
    }
}
