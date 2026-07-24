import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: notifRectRoot

    signal clicked()

    Layout.fillWidth: true
    Layout.preferredHeight: Variables.buttonHeight
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

            StyledText {
                anchors.centerIn: parent
                font.pixelSize: Variables.fontMedium
                color: Colors.on_surface
                text: "Notifications"
            }
        }

        Rectangle {
            id: notifClearBtn
            Layout.fillHeight: true
            Layout.preferredWidth: notifTextContainer.height
            color: notifClearMouse.pressed ? Colors.surface_variant : Colors.surface_container_high
            radius: Variables.dashInnerRadius
            clip: true
            scale: notifClearMouse.pressed ? 0.85 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: Variables.durationFast
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.exitCurve
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }

            StyledText {
                anchors.centerIn: parent
                font.pixelSize: Variables.iconNormal
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
