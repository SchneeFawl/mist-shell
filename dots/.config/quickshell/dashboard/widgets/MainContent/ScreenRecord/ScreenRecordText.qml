import QtQuick
import qs.modules.theme

Text {
    property int size: Variables.fontNormal
    property bool monospace: false

    verticalAlignment: Text.AlignVCenter
    font.family: monospace ? Variables.monoFontFamily : Variables.sansFontFamily
    font.pixelSize: size
    color: Colors.on_surface
    text: ""
}
