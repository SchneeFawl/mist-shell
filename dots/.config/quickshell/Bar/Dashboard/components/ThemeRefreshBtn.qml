import QtQuick
import qs.modules.theme
import qs.services

Rectangle {
    id: btnRoot

    property bool showRefreshedText: false

    color: mouseArea.containsMouse ? Colors.primary : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: mouseArea.pressed ? 0.85 : 1.0

    Text {
        id: refreshText
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
        text: Icons.refresh + " Rescan Themes"
        opacity: btnRoot.showRefreshedText ? 0.0 : 1.

        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Text {
        id: refreshedText
        anchors.centerIn: parent
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
        text: Icons.refresh + " Rescanned Themes!"
        opacity: btnRoot.showRefreshedText ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 260
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutBack
        }
    }

    Timer {
        id: textResetTimer
        interval: 2500
        repeat: false
        onTriggered: btnRoot.showRefreshedText = false
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            ThemeController.rescanThemes();
            btnRoot.showRefreshedText = true;
            textResetTimer.restart();
        }
    }
}
