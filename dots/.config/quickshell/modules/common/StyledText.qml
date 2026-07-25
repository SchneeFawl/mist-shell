import QtQuick
import qs.modules.theme

Text {
    id: styledTextRoot
    verticalAlignment: Text.AlignVCenter
    font.family: Variables.defaultFontFamily
    font.weight: Variables.defaultFontWeight
    font.pixelSize: Variables.fontNormal
    color: Colors.on_surface

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

    Behavior on opacity {
        NumberAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }
}
