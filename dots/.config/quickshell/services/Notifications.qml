pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

NotificationServer {
    id: notifServer

    onNotification: notification => {
        notification.tracked = true
    }
}
