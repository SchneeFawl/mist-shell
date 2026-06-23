pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

NotificationServer {
    id: notifServer

    property bool dndActive: false

    keepOnReload: true

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
}
