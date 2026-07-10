import QtQuick
import qs.modules.theme

Text {
    property int size: 14

    verticalAlignment: Text.AlignVCenter
    font.family: Variables.defaultFontFamily
    font.pixelSize: size
    color: Colors.on_surface
    text: ""
}
