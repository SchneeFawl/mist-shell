pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.modules.theme

Singleton {
    id: batteryRoot

    property bool hasBattery: UPower.displayDevice.isLaptopBattery
    property real batPercentage: UPower.displayDevice.percentage * 100
    property var state: UPower.displayDevice.state
    property bool isCharging: state === UPowerDeviceState.Charging
    // property real chargingTime: UPower.displayDevice.timeToFull
    // property real emptyTime: UPower.displayDevice.timeToEmpty

    readonly property var batteryIcons: [
        Icons.batteryAlert, Icons.battery10, Icons.battery20,
        Icons.battery30, Icons.battery40, Icons.battery50,
        Icons.battery60, Icons.battery70, Icons.battery80,
        Icons.battery90, Icons.batteryFull
    ]

    function getBatteryIcon(percentage) {
        if (percentage >= 100) return Icons.batteryFull;
        if (percentage < 10) return Icons.batteryAlert;
        return batteryIcons[Math.floor(percentage / 10)];
    }
}
