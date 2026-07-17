import QtQuick
import qs.modules.theme

Text {
    property int size: Variables.defaultFontSize

    verticalAlignment: Text.AlignVCenter
    leftPadding: Variables.dashInnerColSpacing
    font.family: Variables.defaultFontFamily
    font.pixelSize: size
    color: Colors.on_surface
    text: ""
}
