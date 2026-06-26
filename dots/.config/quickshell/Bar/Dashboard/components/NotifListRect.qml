import QtQuick
import QtQuick.Layouts
import qs.modules.theme

// qmllint disable unqualified

Rectangle {
    id: notifRectRoot

    signal clicked()

    Layout.fillWidth: true
    Layout.preferredHeight: 36
    radius: Variables.dashInnerRadius
    color: "transparent"
    clip: true

    RowLayout {
        anchors.fill: parent
        clip: true

        Rectangle {
            id: notifTextContainer
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
            clip: true

            Text {
                anchors.centerIn: parent
                font.pixelSize: 16
                font.family: Variables.defaultFontFamily
                font.weight: Variables.defaultFontWeight
                color: Colors.on_surface
                text: "Notifications"
            }
        }

        Rectangle {
            id: notifClearBtn
            Layout.fillHeight: true
            Layout.preferredWidth: notifTextContainer.height
            color: notifClearMouse.pressed ? Colors.surface_variant : Colors.surface_container_high
            radius: width / 2
            clip: true
            scale: notifClearMouse.pressed ? 0.85 : 1.0

            Behavior on color {
                ColorAnimation {
                    duration: 240
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutQuad
                }
            }

            Text {
                color: Colors.on_surface
                anchors.centerIn: parent
                font.pixelSize: Variables.dashIconSize
                font.family: Variables.defaultFontFamily
                text: Icons.actionClear
            }

            MouseArea {
                id: notifClearMouse
                anchors.fill: parent
                onClicked: notifRectRoot.clicked()
            }
        }
    }
}
