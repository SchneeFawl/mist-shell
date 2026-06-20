import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: track

    required property string currentMode

    width: 60
    Layout.fillHeight: true         // 40
    color: currentMode === "dark" ? Colors.surface_container_high : Colors.primary
    radius: Variables.dashInnerRadius + 6
    clip: true

    Behavior on color {
        ColorAnimation { duration: 250 }
    }

    Rectangle {
        id: thumb

        property int margin: 4

        anchors.verticalCenter: parent.verticalCenter
        height: track.height - (margin * 2)
        width: track.width / 2
        radius: track.radius - (margin)
        color: track.currentMode === "dark" ? Colors.primary : Colors.on_primary

        x: track.currentMode === "dark" ? margin : track.width - width - margin

        Behavior on x {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }

        Text {
            anchors.centerIn: parent
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.dashIconSize - 8
            color: track.currentMode === "dark" ? Colors.on_primary : Colors.primary
            text: track.currentMode === "dark" ? Icons.moonCrescent : Icons.sunBright

            Behavior on color {
                ColorAnimation { duration: 250 }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            ThemeController.updateState(
                ThemeController.theme,
                ThemeController.wallpaper,
                (ThemeController.mode === "dark") ? "light" : "dark"
            )
        }
    }
}