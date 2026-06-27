pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import qs.modules.theme
import qs.services

// qmllint disable unresolved-type

Singleton {
    id: btRoot

    readonly property bool enabled: Bluetooth.defaultAdapter?.enabled ?? false
    readonly property bool connected: Bluetooth.devices.values.some(d => d.connected)

    Process {
        command: ["blueman-applet"]
        running: btRoot.enabled
    }

    property var sortedDevices: {
        if (Bluetooth.defaultAdapter && Bluetooth.defaultAdapter.enabled) {
            return Bluetooth.defaultAdapter.devices.values.filter(
                dev => dev.deviceName && dev.deviceName.trim() !== ""
            ).sort(
                (a, b) => {
                    if (a.connected !== b.connected) return a.connected ? -1 : 1
                    if (a.paired !== b.paired) return a.paired ? -1 : 1
                    else return a.deviceName.localeCompare(b.deviceName)
                }
            )
        } else return []
    }

    function getDeviceIcon(iconName) {
        if (iconName.includes("keyboard"))
            return Icons.keyboard;
        if (iconName.includes("mouse"))
            return Icons.mouse;
        if (iconName.includes("tv") || iconName.includes("television"))
            return Icons.television;
        if (iconName.includes("headphones"))
            return Icons.headphones;
        if (iconName.includes("headset"))
            return Icons.headset;
        if (iconName.includes("phone"))
            return Icons.phone;
        return Icons.sysBluetooth;
    }

    function getStatus(device) {
        if (device.connected) {
            return device.battery !== -1 ? "Connected " + (device.batteryAvailable ? Battery.getBatteryIcon(device.battery) : "") : "Connected";
        }
        if (device.paired) return "Paired";
        return "Available";
    }
}
