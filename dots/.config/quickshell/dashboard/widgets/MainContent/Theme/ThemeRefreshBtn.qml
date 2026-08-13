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

    Row {
        id: refreshText
        anchors.centerIn: parent
        spacing: Variables.spacingNormal
        opacity: btnRoot.showRefreshedText ? 0.0 : 1

        StyledText {
            monospace: true
            anchors.verticalCenter: parent.verticalCenter
            color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
            font.pixelSize: Variables.iconNormal
            text: Icons.refresh
        }
        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
            text: "Rescan Themes"
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    Row {
        id: refreshedText
        anchors.centerIn: parent
        spacing: Variables.spacingNormal
        opacity: btnRoot.showRefreshedText ? 1.0 : 0.0

        StyledText {
            monospace: true
            anchors.verticalCenter: parent.verticalCenter
            color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
            font.pixelSize: Variables.iconNormal
            text: Icons.refresh
        }
        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            color: mouseArea.containsMouse ? Colors.on_primary : Colors.on_surface
            text: "Rescanned Themes!"
        }

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
