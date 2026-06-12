import QtQuick
import QtQuick.Layouts
import "./components"
import qs.services

// qmllint disable unqualified

ColumnLayout {
    anchors.fill: parent
    anchors.margins: 5
    spacing: 5

    NotifListRect {
        onClicked: {
            const list = Notifications.trackedNotifications.values;
            for (let i = list.length - 1; i >= 0; i--) {
                list[i].dismiss()
            }
        }
    }

    // notifications list
    Rectangle {
        id: parentRect

        Layout.fillHeight: true
        Layout.fillWidth: true
        radius: 9
        color: "transparent"

        clip: true

        ListView {
            anchors.fill: parent
            clip: true
            spacing: 4
            model: Notifications.trackedNotifications.values

            delegate: Rectangle {
                implicitHeight: 100
                implicitWidth: parentRect.width
                color: themePalette.inactiveAccent
                radius: 9
                clip: true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 7
                    clip: true

                    Text {
                        color: "white"
                        text: modelData.appName
                        font.pixelSize: 14
                    }

                    Text {
                        color: "white"
                        text: modelData.summary
                        font.pixelSize: 12
                    }

                    Text {
                        color: "white"
                        text: modelData.body
                        font.pixelSize: 12
                    }
                }
            }
        }
    }
}
