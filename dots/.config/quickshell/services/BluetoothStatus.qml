pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.modules.theme
import qs.services

// qmllint disable unresolved-type

Singleton {
    id: btRoot

    readonly property bool enabled: Bluetooth.defaultAdapter?.enabled ?? false
    readonly property bool connected: Bluetooth.devices.values.some(d => d.connected)

    function getDeviceIcon(iconName) {
        if (!iconName) return Icons.sysBluetooth;
        if (iconName.includes("keyboard")) return Icons.keyboard;
        if (iconName.includes("mouse")) return Icons.mouse;
        if (iconName.includes("tv") || iconName.includes("television")) return Icons.television;
        if (
            iconName.includes("headphone") || iconName.includes("headphones") ||
            iconName.includes("audio") || iconName.includes("buds")
        ) return Icons.headphones;
        if (iconName.includes("headset")) return Icons.headset;
        if (
            iconName.includes("pc") || iconName.includes("desktop") || iconName.includes("laptop")
        ) return Icons.laptop;
    }

    function getStatus(device) {
        if (device.connected) {
            return device.battery !== -1 ? "Connected " + Battery.getBatteryIcon(device.battery) : "Connected";
        }
        if (device.paired) return "Paired";
        return "Available";
    }
}
