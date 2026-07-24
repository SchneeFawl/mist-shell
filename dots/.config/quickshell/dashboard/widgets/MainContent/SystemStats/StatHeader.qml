import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

RowLayout {
    id: statHeaderRoot

    property string text: ""
    property string icon: ""
    property color iconColor: Colors.on_surface

    Layout.fillWidth: true
    Layout.preferredHeight: Math.round(20 * Variables.scaleFactor)
    Layout.alignment: Qt.AlignCenter
    spacing: Variables.dashInnerColSpacing + Math.round(3 * Variables.scaleFactor)

    StyledText {
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Variables.fontMedium
        color: statHeaderRoot.iconColor
        text: statHeaderRoot.icon
    }

    StyledText {
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Variables.fontMedium - 1
        text: statHeaderRoot.text
    }
}
