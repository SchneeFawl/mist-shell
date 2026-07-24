import QtQuick
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: btnRoot

    property bool showRefreshedText: false

    color: mouseArea.containsMouse ? Colors.primary : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: mouseArea.pressed ? 0.85 : 1.0

    StyledText {
        id: refreshText
        anchors.centerIn: parent
        color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
        text: Icons.refresh + " Rescan Themes"
        opacity: btnRoot.showRefreshedText ? 0.0 : 1

        Behavior on opacity {
            NumberAnimation {
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    StyledText {
        id: refreshedText
        anchors.centerIn: parent
        color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
        text: Icons.refresh + " Rescanned Themes!"
        opacity: btnRoot.showRefreshedText ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
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
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            ThemeController.rescanThemes();
            btnRoot.showRefreshedText = true;
            textResetTimer.restart();
        }
    }
}
