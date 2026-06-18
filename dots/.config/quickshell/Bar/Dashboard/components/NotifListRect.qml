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
                color: Colors.on_surface
                text: "Notifications"
                font.pixelSize: 16
                font.family: Variables.defaultFontFamily
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: notifClearBtn
            Layout.fillHeight: true
            Layout.preferredWidth: notifTextContainer.height
            color: notifClearMouse.pressed ? Colors.surface_variant : Colors.surface_container_high
            radius: width / 2
            clip: true

            Behavior on color {
                ColorAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                color: Colors.on_surface
                anchors.centerIn: parent
                text: Icons.actionClear
                font.pixelSize: Variables.dashIconSize
                font.family: Variables.defaultFontFamily
            }

            MouseArea {
                id: notifClearMouse
                anchors.fill: parent
                onClicked: notifRectRoot.clicked()
            }
        }
    }
}
