import QtQuick
import qs.modules.theme

Rectangle {
    property Item hoveredPill
    property Item activePill
    property Item targetPill: hoveredPill ?? activePill

    height: parent.height
    width: targetPill?.width ?? 0
    x: targetPill?.x ?? 0
    radius: Variables.dashInnerRadius
    color: Colors.primary
    opacity: targetPill ? 1.0 : 0

    Behavior on x {
        NumberAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }
}

