pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.services
import qs.modules.theme
import qs.modules.common

PanelWindow {           // qmllint disable uncreatable-type
    id: notifPopup

    required property var modelData
    property var notif
    property bool active: notifModel.count > 0

    property var activeNotifications: []
    property var activeNotificationsMap: ({})

    anchors {
        right: true
        top: true
    }

    margins {       // qmllint disable unresolved-type unqualified
        top: Variables.spacingSmall + Math.round(1 * Variables.scaleFactor)
        right: Variables.spacingSmall + Math.round(1 * Variables.scaleFactor)
    }

    // implicitHeight: Math.min(200*4, notifListView.contentHeight)
    implicitHeight: Math.round(800 * Variables.scaleFactor)
    implicitWidth: Math.round(360 * Variables.scaleFactor)
    color: "transparent"
    visible: active || exitTimer.running

    ListModel {
        id: notifModel
    }

    ListView {
        id: notifListView

        model: notifModel
        spacing: Variables.spacingSmall
        anchors.fill: parent

        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 240
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        remove: Transition {
            ParallelAnimation {
                id: exitAnim
                NumberAnimation {
                    property: "x"
                    to: notifPopup.width
                    duration: Variables.durationFast
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.exitCurve
                }
                NumberAnimation {
                    property: "opacity"
                    to: 0.0
                    duration: 480
                }
            }
        }

        delegate: Item {
            id: notifCard

            required property int notifId
            required property var index
            property real progress: 1.0

            property string appName: ""
            property string summary: ""
            property string body: ""
            property string resolvedIcon: ""
            property int urgency: 0

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
                onFinished: {
                    let obj = notifPopup.activeNotificationsMap[notifCard.notifId];
                    if (obj) obj.dismiss();
                }
            }

            Component.onCompleted: {
                let obj = notifPopup.activeNotificationsMap[notifId];
                if (obj) {
                    appName = obj.appName || "";
                    summary = obj.summary || "";
                    body = obj.body || "";
                    resolvedIcon = obj.image || obj.appIcon || "";
                    appName = obj.appName || 0;
                }
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
                opacity: 0.20

                layer.enabled: entryAnim.running
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blurMax: 24
                    blur: 1.0
                }
            }

            ClippingRectangle {
                id: cardBg

                width: Math.round(320 * Variables.scaleFactor)
                height: cardLayout.implicitHeight + Math.round((14 + 12) * Variables.scaleFactor)
                anchors.right: parent.right
                anchors.rightMargin: Math.round(20 * Variables.scaleFactor)

                radius: Variables.pillRadius
                color: Colors.primary_container
                border.width: 2
                border.color: Notifications.getUrgencyColor(notifCard.urgency, Colors.error, Colors.border)

                Rectangle {
                    id: progressBar
                    width: notifCard ? (cardBg.width - Math.round(20 * Variables.scaleFactor)) * notifCard.progress : 0
                    height: Math.round(3 * Variables.scaleFactor)
                    anchors.top: parent.top
                    anchors.left: parent.left
                    color: Notifications.getUrgencyColor(notifCard.urgency, Colors.on_error_container, Colors.primary)
                    radius: Variables.radiusSmall - Math.round(2 * Variables.scaleFactor)
                }
            }

            ParallelAnimation {
                id: entryAnim
                NumberAnimation {
                    target: notifCard
                    property: "x"
                    to: 0
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.overshootCurve
                }
                NumberAnimation {
                    target: notifCard
                    property: "opacity"
                    to: 1.0
                    duration: 120
                }
            }

            RowLayout {
                id: cardLayout
                anchors.top: cardBg.top
                anchors.left: cardBg.left
                anchors.right: cardBg.right
                anchors.topMargin: Variables.spacingLarge - Math.round(2 * Variables.scaleFactor)
                anchors.leftMargin: Variables.spacingMedium
                anchors.rightMargin: Variables.spacingMedium
                spacing: Variables.spacingNormal

                ClippingRectangle {
                    id: iconImageContainer

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: visible ? Variables.buttonHeightMedium : 0
                    Layout.preferredWidth: visible ? Variables.buttonHeightMedium : 0
                    visible: !!notifCard.resolvedIcon
                    color: "transparent"
                    radius: width / 2

                    IconImage {
                        anchors.fill: parent
                        mipmap: true
                        asynchronous: true
                        source: Notifications.resolvedIcon(notifCard.resolvedIcon)
                    }
                }

                // notif content
                ColumnLayout {
                    id: cardContentLayout
                    Layout.fillWidth: true
                    spacing: Variables.spacingNormal
                    clip: true

                    StyledText {
                        Layout.fillWidth: true
                        color: Colors.secondary
                        text: notifCard.appName
                    }

                    StyledText {
                        Layout.fillWidth: true
                        color: Colors.on_primary_container
                        font.pixelSize: Variables.fontMedium - 1
                        text: notifCard.summary
                        elide: Text.ElideRight
                    }

                    StyledText {
                        Layout.fillWidth: true
                        color: Colors.tertiary
                        font.pixelSize: Variables.fontSmall
                        text: notifCard.body
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
                    let obj = notifPopup.activeNotificationsMap[notifCard.notifId];
                    if (obj) obj.dismiss();
                    progressAnim.stop();
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
            if (!Notifications.dndActive) {
                notifPopup.activeNotificationsMap[notification.id] = notification;
                notifPopup.activeNotificationsMapChanged();

                notifModel.append({ "notifId": notification.id });
            }

            notification.closed.connect(() => {
                for (let i = 0; i < notifModel.count; i++) {
                    if (notifModel.get(i).notifId === notification.id) {
                        notifModel.remove(i);
                        break;
                    }
                }
                delete notifPopup.activeNotificationsMap[notification.id];
                notifPopup.activeNotificationsMapChanged();
            });

            // DEBUG:
            // console.log("NOTIF received - appIcon:", notification.appIcon, "| image:", notification.image)
        }
    }
}
