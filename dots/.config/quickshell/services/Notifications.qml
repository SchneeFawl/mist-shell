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

        if (icon.startsWith("file://") || icon.startsWith("image://")) {
            return icon;
        }
        if (icon.startsWith("qrc:/") || icon.startsWith("/")) {
            return "file://" + icon;
        }

        return Quickshell.iconPath(icon);
    }
}
