import QtQuick
import qs.modules.theme

Text {
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
}
