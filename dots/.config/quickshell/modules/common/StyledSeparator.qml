import QtQuick
import qs.modules.theme

Rectangle {
    id: root

    property color middleColor: Colors.border_variant

    height: Math.round(2 * Variables.scaleFactor)
    width: parent.width

    gradient: Gradient {
        orientation: Gradient.Horizontal

        GradientStop {
            position: 0.0
            color: "transparent"
        }
        GradientStop {
            position: 0.25
            color: root.middleColor
        }
        GradientStop {
            position: 0.75
            color: root.middleColor
        }
        GradientStop {
            position: 1.0
            color: "transparent"
        }
    }
}

