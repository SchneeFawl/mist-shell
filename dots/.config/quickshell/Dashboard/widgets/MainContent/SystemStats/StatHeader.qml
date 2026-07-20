import QtQuick
import QtQuick.Layouts
import qs.modules.theme

RowLayout {
    id: statHeaderRoot

    property string text: ""
    property string icon: ""
    property color iconColor: Colors.on_surface

    Layout.fillWidth: true
    Layout.preferredHeight: Math.round(20 * Variables.scaleFactor)
    Layout.alignment: Qt.AlignCenter
    spacing: Variables.dashInnerColSpacing + Math.round(3 * Variables.scaleFactor)

    Text {
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.fontMedium
        color: statHeaderRoot.iconColor
        text: statHeaderRoot.icon
    }

    Text {
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.fontMedium - 1
        color: Colors.on_surface
        text: statHeaderRoot.text
    }
}
