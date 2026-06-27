import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../components"
import qs.services
import qs.modules.theme

// qmllint disable unqualified

ColumnLayout {
    id: notifListRoot

    property bool active: false

    anchors.fill: parent
    anchors.margins: Variables.dashInnerColSpacing
    spacing: Variables.dashInnerColSpacing + 3

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
                    duration: 240
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 120
                }
            }

            property Transition exitTransition: Transition {
                NumberAnimation {
                    property: "x"
                    to: parentRect.width
                    duration: 240
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 480
                }
            }

            add: active ? entryTransition : null

            remove: active ? exitTransition : null

            displaced: Transition {
                NumberAnimation {
                    property: "y"
                    duration: 240
                    easing.type: Easing.OutQuad
                }
            }

            delegate: Rectangle {
                id: card

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
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8
                    clip: true

                    ClippingRectangle {
                        id: iconContainer
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredHeight: 50
                        Layout.preferredWidth: 50
                        visible: !!card.resolvedIcon
                        color: "transparent"
                        radius: width / 2

                        IconImage {
                            anchors.fill: parent
                            mipmap: true
                            asynchronous: true
                            source: {
                                let icon = card.resolvedIcon;
                                if (!icon) return "";

                                if (
                                    icon.startsWith("/") || icon.startsWith("file://") ||
                                    icon.startsWith("qrc:/") || icon.startsWith("image://")
                                ) {
                                    return icon;
                                }

                                return Quickshell.iconPath(icon);
                            }
                        }
                    }

                    ColumnLayout {
                        id: contentLayout
                        Layout.fillWidth: true
                        spacing: 8
                        clip: true

                        Text {
                            Layout.fillWidth: true
                            color: Colors.secondary
                            font.family: Variables.defaultFontFamily
                            font.pixelSize: 14
                            text: modelData.appName
                        }

                        Text {
                            Layout.fillWidth: true
                            color: Colors.on_primary_container
                            font.family: Variables.defaultFontFamily
                            font.pixelSize: 15
                            text: modelData.summary
                            elide: Text.ElideRight
                        }

                        Text {
                            Layout.fillWidth: true
                            color: Colors.tertiary
                            font.pixelSize: 13
                            font.family: Variables.defaultFontFamily
                            text: modelData.body
                            wrapMode: Text.WordWrap
                            maximumLineCount: 3
                            elide: Text.ElideRight
                        }
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
