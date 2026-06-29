pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

NotificationServer {
    id: notifServer

    property bool dndActive: false

    onNotification: notification => {
        notification.tracked = true
    }

    function getUrgencyColor(urgency, criticalColor, fallbackColor) {
        if (urgency === NotificationUrgency.Critical) {
            return criticalColor;
        } else {
            return fallbackColor;
        }
    }

    function resolvedIcon(icon) {
        if (!icon) return "";

        if (icon.startsWith("/") || icon.startsWith("file://") ||
            icon.startsWith("qrc:/") || icon.startsWith("image://")) {
            return icon;
        }

        return Quickshell.iconPath(icon);
    }
}
