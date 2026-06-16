import QtQuick
import qs.modules.theme

Text {
    id: label

    property bool isSubText: false

    font.family: Variables.defaultFontFamily
    font.pixelSize: isSubText ? 11 : 13
    font.weight: isSubText ? Font.Normal : Font.Bold
    color: isSubText ? Colors.textSub : Colors.textMain
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
}
