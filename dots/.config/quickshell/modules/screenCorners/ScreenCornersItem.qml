import QtQuick
import QtQuick.Shapes
import qs.modules.theme

Item {
    id: cornerRoot

    enum CornerEnum { TopLeft, TopRight, BottomLeft, BottomRight }
    property var corner: ScreenCornersItem.CornerEnum.TopLeft
    property color color: Colors.primary_container
    property int radius: Variables.screenCornerRadius

    implicitHeight: radius
    implicitWidth: radius
    clip: true

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shapePath
            strokeWidth: 0
            fillColor: cornerRoot.color
            startX: {
                if (cornerRoot.corner === ScreenCornersItem.CornerEnum.TopRight ||
                    cornerRoot.corner === ScreenCornersItem.CornerEnum.BottomRight) return cornerRoot.radius;
                return 0;
            }
            startY: {
                if (cornerRoot.corner === ScreenCornersItem.CornerEnum.BottomLeft ||
                    cornerRoot.corner === ScreenCornersItem.CornerEnum.BottomRight) return cornerRoot.radius;
                return 0;
            }

            PathAngleArc {
                moveToStart: false
                centerX: cornerRoot.radius - shapePath.startX
                centerY: cornerRoot.radius - shapePath.startY
                radiusX: cornerRoot.radius; radiusY: cornerRoot.radius
                startAngle: switch (cornerRoot.corner) {
                    case ScreenCornersItem.CornerEnum.TopLeft: return 180;
                    case ScreenCornersItem.CornerEnum.TopRight: return -90;
                    case ScreenCornersItem.CornerEnum.BottomLeft: return 90;
                    case ScreenCornersItem.CornerEnum.BottomRight: return 0;
                }
                sweepAngle: 90
            }

            PathLine {
                x: shapePath.startX
                y: shapePath.startY
            }
        }
    }
}
