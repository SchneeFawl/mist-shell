import QtQuick

Text {
    id: label

    property bool isSubText: false

    font.family: "Maple Mono Normal"
    font.pixelSize: isSubText ? 11 : 13
    font.weight: isSubText ? Font.Normal : Font.Bold
    color: isSubText ? themePalette.textSub : themePalette.textMain
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
}
