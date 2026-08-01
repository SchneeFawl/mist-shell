import QtQuick
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: btnRoot

    property string icon: ""
    property color iconColor: Colors.on_surface
    property string text: ""
    property color textColor: Colors.on_surface
    property bool hasIcon: icon !== ""
    property bool hasText: text !== ""

    property int iconSize: Variables.iconNormal

    signal clicked()
    signal rightClicked()

    implicitWidth: textRow.width + Variables.spacingLarge + Variables.spacingSmall
    implicitHeight: Variables.buttonHeight
    radius: Variables.dashInnerRadius
    color: Colors.surface_container_highest
    scale: mouseArea.pressed ? 0.85 : 1.0
    clip: true

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    Row {
        id: textRow
        anchors.centerIn: parent
        spacing: Variables.spacingNormal

        StyledText {
            id: iconText
            font.pixelSize: btnRoot.iconSize
            color: btnRoot.iconColor
            text: btnRoot.icon
            visible: btnRoot.hasIcon
        }

        StyledText {
            id: btnText
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Variables.fontNormal
            color: btnRoot.textColor
            text: btnRoot.text
            visible: btnRoot.hasText
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
        onClicked: btnRoot.clicked()
    }
}

