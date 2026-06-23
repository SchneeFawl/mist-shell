import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.services
import qs.modules.theme

// qmllint disable unqualified

PanelWindow {           // qmllint disable uncreatable-type
    id: notifPopup

    required property var modelData
    property var notif
    property bool active: notifModel.count > 0

    anchors {
        right: true
        top: true
    }

    margins {       // qmllint disable unresolved-type
        top: 5
        right: 5
    }

    // implicitHeight: Math.min(200*4, notifListView.contentHeight)
    implicitHeight: 800
    implicitWidth: 340
    color: "transparent"
    visible: active || exitTimer.running

    ListModel {
        id: notifModel
    }

    ListView {
        id: notifListView

        model: notifModel
        spacing: 4
        anchors.fill: parent

        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 240
                easing.type: Easing.OutQuad
            }
        }

        delegate: Item {
            id: notifCard

            property real progress: 1.0
            readonly property var resolvedIcon: model.notifObject.image || model.notifObject.appIcon || ""

            height: cardBg.height + 8
            width: notifPopup.width
            x: notifPopup.width
            opacity: 0.0

            NumberAnimation {
                id: progressAnim
                target: notifCard
                property: "progress"
                to: 0.0
                duration: 7000
                onFinished: exitAnim.start()
            }

            Component.onCompleted: {
                entryAnim.start();
                progressAnim.start();
            }

            Rectangle {
                id: cardShadow

                anchors.top: cardBg.top
                anchors.right: cardBg.right
                anchors.left: cardBg.left
                anchors.bottom: cardBg.bottom
                anchors.topMargin: 8
                anchors.bottomMargin: -4
                anchors.rightMargin: -4

                radius: Variables.pillRadius
                color: "black"
                opacity: mouseArea.containsMouse ? 0.25 : 0.15

                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blurMax: 24
                    blur: 1.0
                }

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }

            ClippingRectangle {
                id: cardBg

                width: 320
                height: cardLayout.implicitHeight + 14 + 12
                anchors.right: parent.right
                anchors.rightMargin: 20

                radius: Variables.pillRadius
                color: Colors.primary_container
                border.width: 2
                border.color: Notifications.getUrgencyColor(model.notifObject.urgency, Colors.error, Colors.border)

                Rectangle {
                    id: progressBar
                    width: (cardBg.width - 20) * notifCard.progress
                    height: 3
                    anchors.top: parent.top
                    anchors.left: parent.left
                    color: Notifications.getUrgencyColor(model.notifObject.urgency, Colors.on_error_container, Colors.primary)
                    radius: 2
                }
            }

            ParallelAnimation {
                id: entryAnim
                NumberAnimation {
                    target: notifCard
                    property: "x"
                    to: 0
                    duration: 240
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: notifCard
                    property: "opacity"
                    to: 1.0
                    duration: 120
                }
            }

            ParallelAnimation {
                id: exitAnim

                NumberAnimation {
                    target: notifCard
                    property: "x"
                    to: notifPopup.width
                    duration: 240
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: notifCard
                    property: "opacity"
                    to: 0.0
                    duration: 480
                }
                onFinished: notifModel.remove(index)
            }

            RowLayout {
                id: cardLayout
                anchors.top: cardBg.top
                anchors.left: cardBg.left
                anchors.right: cardBg.right
                anchors.topMargin: 14
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 8

                ClippingRectangle {
                    id: iconImageContainer

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: visible ? 50 : 0
                    Layout.preferredWidth: visible ? 50 : 0
                    visible: !!notifCard.resolvedIcon
                    color: "transparent"
                    radius: width / 2

                    IconImage {
                        anchors.fill: parent
                        mipmap: true
                        asynchronous: true
                        source: notifCard.resolvedIcon
                    }
                }

                // notif content
                ColumnLayout {
                    id: cardContentLayout
                    Layout.fillWidth: true
                    spacing: 8
                    clip: true

                    Text {
                        Layout.fillWidth: true
                        color: Colors.secondary
                        font.pixelSize: 14
                        font.family: Variables.defaultFontFamily
                        renderType: Text.NativeRendering
                        text: model.notifObject.appName
                    }

                    Text {
                        Layout.fillWidth: true
                        color: Colors.on_primary_container
                        font.pixelSize: 15
                        font.family: Variables.defaultFontFamily
                        renderType: Text.NativeRendering
                        text: model.notifObject.summary
                        elide: Text.ElideRight
                    }

                    Text {
                        Layout.fillWidth: true
                        color: Colors.tertiary
                        font.pixelSize: 13
                        font.family: Variables.defaultFontFamily
                        renderType: Text.NativeRendering
                        text: model.notifObject.body
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                    }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: cardBg
                onClicked: {
                    model.notifObject.dismiss();
                    progressAnim.stop();
                    exitAnim.start();
                }
            }
        }
    }

    Timer {
        id: exitTimer
        running: false
        repeat: false
        interval: 250
    }

    onActiveChanged: exitTimer.start();

    Connections {
        target: Notifications

        function onNotification(notification) {
            notifModel.append({ "notifObject" : notification })

            // DEBUG:
            // console.log("NOTIF received - appIcon:", notification.appIcon, "| image:", notification.image)
        }
    }
}
