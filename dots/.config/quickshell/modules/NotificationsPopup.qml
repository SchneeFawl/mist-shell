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

                width: 300
                height: cardContentLayout.height + 20
                anchors.right: parent.right
                anchors.rightMargin: 20

                radius: Variables.pillRadius
                color: Colors.secondary_container
                border.width: 2
                border.color: Colors.border

                Rectangle {
                    id: progressBar
                    width: (cardBg.width - 20) * notifCard.progress
                    height: 2
                    anchors.top: parent.top
                    anchors.left: parent.left
                    color: Colors.primary
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

            // notif content
            ColumnLayout {
                id: cardContentLayout
                anchors.top: cardBg.top
                anchors.left: cardBg.left
                anchors.right: cardBg.right
                anchors.topMargin: 12
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 8
                clip: true

                Text {
                    Layout.fillWidth: true
                    color: Colors.primary
                    font.pixelSize: 15
                    font.family: Variables.defaultFontFamily
                    renderType: Text.NativeRendering
                    text: model.notifObject.appName
                }

                Text {
                    Layout.fillWidth: true
                    color: Colors.textVibrant
                    font.pixelSize: 14
                    font.family: Variables.defaultFontFamily
                    renderType: Text.NativeRendering
                    text: model.notifObject.summary
                }

                Text {
                    Layout.fillWidth: true
                    color: Colors.textSub
                    font.pixelSize: 13
                    font.family: Variables.defaultFontFamily
                    renderType: Text.NativeRendering
                    text: model.notifObject.body
                    wrapMode: Text.WordWrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
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
        }
    }
}
