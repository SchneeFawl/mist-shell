pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

NotificationServer {
    id: notifServer

    keepOnReload: false

    onNotification: notification => {
        notification.tracked = true
    }
}
