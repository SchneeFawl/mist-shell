import QtQuick
import qs.modules.theme

Text {
    property int size: Variables.fontNormal

    verticalAlignment: Text.AlignVCenter
    font.family: Variables.defaultFontFamily
    font.pixelSize: size
    color: Colors.on_surface
    text: ""
}
