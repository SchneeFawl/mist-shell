import QtQuick
import QtQuick.Layouts

// qmllint disable unqualified

Rectangle {
    id: notifRectRoot

    signal clicked()

    Layout.fillWidth: true
    Layout.preferredHeight: 36
    radius: 9
    color: "transparent"
    clip: true

    RowLayout {
        anchors.fill: parent
        clip: true

        Rectangle {
            id: notifTextContainer
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: themePalette.inactiveAccent
            radius: 9
            clip: true

            Text {
                color: "white"
                text: "Notifications"
                font.pixelSize: 16
                font.family: "Maple Mono Normal"
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: notifClearBtn
            Layout.fillHeight: true
            Layout.preferredWidth: notifTextContainer.height
            color: notifClearMouse.pressed ? themePalette.activeBtnVibrant : themePalette.inactiveAccent
            radius: width / 2
            clip: true

            Behavior on color {
                ColorAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                color: "white"
                anchors.centerIn: parent
                text: "󰃢"
                font.pixelSize: 24
            }

            MouseArea {
                id: notifClearMouse
                anchors.fill: parent
                onClicked: notifRectRoot.clicked()
            }
        }
    }
}
