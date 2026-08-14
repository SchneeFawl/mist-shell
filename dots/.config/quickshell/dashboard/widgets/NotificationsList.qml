pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import "../components"
import qs.services
import qs.modules.theme
import qs.modules.common

ColumnLayout {
    id: notifListRoot

    property bool active: false

    anchors.fill: parent
    anchors.margins: Variables.dashInnerColSpacing
    spacing: Variables.dashInnerColSpacing

    NotifListHeader {
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
        radius: Variables.dashInnerRadius
        color: "transparent"

        clip: true

        ListView {
            anchors.fill: parent
            spacing: Variables.dashInnerColSpacing
            clip: true
            model: Notifications.trackedNotifications

            property Transition entryTransition: Transition {
                NumberAnimation {
                    property: "x"
                    from: -parentRect.width
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.entranceCurve
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: Variables.durationFast
                }
            }

            property Transition exitTransition: Transition {
                NumberAnimation {
                    property: "x"
                    to: parentRect.width
                    duration: Variables.durationFast
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.exitCurve
                }
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: Variables.durationMedium * 2
                }
            }

            add: notifListRoot.active ? entryTransition : null

            remove: notifListRoot.active ? exitTransition : null

            displaced: Transition {
                NumberAnimation {
                    property: "y"
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }

            delegate: Rectangle {
                id: card

                required property var modelData
                readonly property var resolvedIcon: modelData.image || modelData.appIcon || ""

                implicitHeight: cardLayout.implicitHeight + 14 + 12
                implicitWidth: parentRect.width
                radius: Variables.dashInnerRadius
                color: Colors.primary_container
                border.width: 2
                border.color: Notifications.getUrgencyColor(modelData.urgency, Colors.error, Colors.border)
                clip: true

                RowLayout {
                    id: cardLayout
                    anchors.top: card.top
                    anchors.left: card.left
                    anchors.right: card.right
                    anchors.topMargin: 14
                    anchors.leftMargin: Variables.spacingMedium
                    anchors.rightMargin: Variables.spacingMedium
                    spacing: Variables.spacingNormal
                    clip: true

                    ClippingRectangle {
                        id: iconContainer
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredHeight: Variables.buttonHeightMedium
                        Layout.preferredWidth: Variables.buttonHeightMedium
                        visible: !!card.resolvedIcon
                        color: "transparent"
                        radius: width / 2

                        IconImage {
                            anchors.fill: parent
                            mipmap: true
                            asynchronous: true
                            source: Notifications.resolvedIcon(card.resolvedIcon)
                        }
                    }

                    ColumnLayout {
                        id: contentLayout
                        Layout.fillWidth: true
                        spacing: Variables.spacingNormal
                        clip: true

                        StyledText {
                            Layout.fillWidth: true
                            color: Colors.secondary
                            text: card.modelData.appName
                        }

                        StyledText {
                            Layout.fillWidth: true
                            color: Colors.on_primary_container
                            font.pixelSize: Variables.fontMedium - 1
                            text: card.modelData.summary
                            elide: Text.ElideRight
                        }

                        StyledText {
                            Layout.fillWidth: true
                            color: Colors.tertiary
                            font.pixelSize: Variables.fontSmall
                            text: card.modelData.body
                            wrapMode: Text.WordWrap
                            maximumLineCount: 3
                            elide: Text.ElideRight
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: card.modelData.dismiss()
                }
            }
        }
    }
}
