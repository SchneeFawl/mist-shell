import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: recBtnRoot

    property string icon: ""
    property string text: ""

    property bool fillWidth: false
    property color pressedColor: Colors.surface_container_highest
    property color unpressedColor: Colors.surface_container_high
    property color textColor1: Colors.on_surface
    property color textColor2: Colors.on_surface
    property var mouseArea: mouseArea
    signal clicked()

    Layout.preferredHeight: 36
    Layout.preferredWidth: fillWidth ? -1 : 36
    Layout.fillWidth: fillWidth
    radius: Variables.dashInnerRadius
    color: mouseArea.pressed ? pressedColor : unpressedColor
    scale: mouseArea.pressed ? 0.85 : 1.0

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

    RowLayout {
        anchors.centerIn: parent
        spacing: 6

        Text {
            visible: recBtnRoot.icon !== ""
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontLarge
            color: mouseArea.pressed ? recBtnRoot.textColor2 : recBtnRoot.textColor1
            text: recBtnRoot.icon

            Behavior on color {
                ColorAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }

        Text {
            visible: recBtnRoot.text !== ""
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontNormal
            color: mouseArea.pressed ? recBtnRoot.textColor2 : recBtnRoot.textColor1
            text: recBtnRoot.text

            Behavior on color {
                ColorAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: recBtnRoot.clicked()
    }
}
