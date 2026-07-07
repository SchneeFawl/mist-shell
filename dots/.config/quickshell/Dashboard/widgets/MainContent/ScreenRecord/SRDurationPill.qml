import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Rectangle {
    id: durationPillRoot

    signal clicked()
    readonly property bool isHovered: mouseArea.containsMouse
    property bool editable: false
    property bool active: false
    property string staticText: "60s"

    Layout.preferredHeight: parent.height
    Layout.fillWidth: true
    radius: Variables.dashInnerRadius
    color: active ? Colors.primary : Colors.surface_container_highest
    border.color: Colors.border
    border.width: editable ? 1 : 0
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

    TextInput {
        anchors.centerIn: parent
        visible: durationPillRoot.editable
        color: durationPillRoot.active ? Colors.on_primary : Colors.on_surface
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        cursorVisible: true
        clip: true
        validator: IntValidator { bottom: 10; top: 3600 }
        text: ScreenRecordService.replayDuration.toString()

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    ScreenRecordText {
        anchors.centerIn: parent
        visible: !durationPillRoot.editable
        color: durationPillRoot.active ? Colors.on_primary : Colors.on_surface
        text: durationPillRoot.staticText

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: durationPillRoot.clicked()
    }
}
