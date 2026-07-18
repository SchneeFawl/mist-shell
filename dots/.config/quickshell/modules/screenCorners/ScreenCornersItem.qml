import QtQuick
import qs.modules.theme

Item {
    id: cornerRoot

    // 0: TopLeft, 1: TopRight, 2: BottomLeft, 3: BottomRight
    property int corner: 0
    property color color: "black"
    property int radius: Variables.screenCornerRadius

    implicitHeight: radius
    implicitWidth: radius
    clip: true

    Rectangle {
        width: cornerRoot.radius * 2
        height: cornerRoot.radius * 2
        color: "transparent"
        radius: cornerRoot.radius
        border.width: cornerRoot.radius
        border.color: cornerRoot.color

        x: (cornerRoot.corner === 1 || cornerRoot.corner === 3) ? -cornerRoot.radius : 0
        y: (cornerRoot.corner === 2 || cornerRoot.corner === 3) ? -cornerRoot.radius: 0
    }
}
