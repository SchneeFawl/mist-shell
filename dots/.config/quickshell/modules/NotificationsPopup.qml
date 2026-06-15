import QtQuick
import Quickshell
import qs.services
import qs.modules.theme

// qmllint disable unqualified

PanelWindow {           // qmllint disable uncreatable-type
    id: notifPopup

    required property var modelData
    property var notif

    anchors {
        right: true
        top: true
    }

    margins {       // qmllint disable unresolved-type unqualified
        top: 5
        right: 5
    }

    implicitHeight: Math.min(200, notifListView.contentHeight)
    implicitWidth: 300
    color: "transparent"

    ListModel {
        id: notifModel
    }

    ListView {
        id: notifListView

        model: notifModel
        spacing: 4
        anchors.fill: parent

        add: Transition {
            NumberAnimation {
                property: "x"
                from: notifPopup.width
                duration: 200
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                property: "x"
                to: notifPopup.width
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutQuad
            }
        }

        delegate: Rectangle {
            implicitHeight: 80
            implicitWidth: notifPopup.width
            color: Colors.inactiveAccent
            border.color: Colors.pillBorder
            border.width: 2
            radius: 12
            clip: true

            Column {
                anchors.fill: parent
                anchors.margins: 7
                clip: true

                Text {
                    color: Colors.textVibrant
                    text: model.notifObject.appName
                    font.pixelSize: 14
                }

                Text {
                    color: Colors.textMain
                    text: model.notifObject.summary
                    font.pixelSize: 12
                }

                Text {
                    color: Colors.textSub
                    text: model.notifObject.body
                    font.pixelSize: 12
                    elide: Text.ElideMiddle
                }
            }

            Timer {
                id: notifTimer
                interval: 5000
                running: true
                repeat: false
                onTriggered: { notifModel.remove(index) }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    model.notifObject.dismiss();
                    notifModel.remove(index)
                }
            }
        }
    }

    Connections {
        target: Notifications

        function onNotification(notification) {
            notifModel.append({ "notifObject" : notification})
        }
    }
}
