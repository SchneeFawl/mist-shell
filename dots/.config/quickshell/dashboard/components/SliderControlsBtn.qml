import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: sliderButtonRoot

    property string icon: ""
    property bool muted: false

    property int active
    signal clicked()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: active ? (muted ? Colors.error : Colors.primary) : Colors.surface_container_high
    radius: Variables.dashInnerRadius
    scale: mouseArea.pressed ? 0.85 : 1.0
    clip: true

    StyledText {
        anchors.centerIn: parent
        color: {
            sliderButtonRoot.active ?
            ( sliderButtonRoot.muted ? Colors.on_tertiary : Colors.on_primary) : Colors.on_surface
        }
        font.pixelSize: Variables.iconNormal
        text: sliderButtonRoot.icon
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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: sliderButtonRoot.clicked()
    }
}
