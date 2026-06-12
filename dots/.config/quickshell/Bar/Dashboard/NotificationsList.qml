import QtQuick
import QtQuick.Layouts
import "./components"
import qs.services

// qmllint disable unqualified

ColumnLayout {
    property bool active: false

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
            model: Notifications.trackedNotifications

            property Transition entryTransition: Transition {
                NumberAnimation {
                    property: "x"
                    from: -parentRect.width
                    duration: 200
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
            }

            property Transition exitTransition: Transition {
                NumberAnimation {
                    property: "x"
                    to: parentRect.width
                    duration: 200
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 200
                }
            }

            add: active ? entryTransition : null

            remove: active ? exitTransition : null

            displaced: Transition {
                NumberAnimation {
                    property: "y"
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }

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
                        color: themePalette.textVibrant
                        text: modelData.appName
                        font.pixelSize: 14
                    }

                    Text {
                        color: themePalette.textMain
                        text: modelData.summary
                        font.pixelSize: 12
                    }

                    Text {
                        color: themePalette.textSub
                        text: modelData.body
                        font.pixelSize: 12
                        elide: Text.ElideMiddle
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.dismiss()
                }
            }
        }
    }
}
