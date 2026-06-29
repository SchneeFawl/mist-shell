import QtQuick
import qs.modules.theme

Text {
    id: label

    property bool isSubText: false

    font.family: Variables.defaultFontFamily
    font.pixelSize: isSubText ? 11 : 13
    font.weight: isSubText ? Variables.defaultFontWeight - 100 : Variables.defaultFontWeight
    color: isSubText ? Colors.textSub : Colors.primary
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    opacity: 1.0
}
