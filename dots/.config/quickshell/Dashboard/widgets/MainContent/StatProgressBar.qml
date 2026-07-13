import QtQuick
import QtQuick.Layouts
import qs.modules.theme

ColumnLayout {
    id: statProgBarRoot

    property string title: ""
    property var progress: 0.0
    property string leftSubText: ""
    property string rightSubText: ""

    height: 50
    width: parent.width
    spacing: Variables.dashInnerColSpacing

    Text {
        Layout.fillWidth: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        color: Colors.on_surface
        text: statProgBarRoot.title
    }

    Rectangle {
        id: sliderRoot
        Layout.preferredWidth: parent.width - (Variables.dashInnerColSpacing * 2)
        Layout.preferredHeight: 18
        Layout.alignment: Qt.AlignHCenter
        color: Colors.surface_container_high
        border.width: 2
        border.color: Colors.border_variant
        radius: Variables.dashInnerRadius

        Rectangle {
            id: sliderFill
            width: parent.width * statProgBarRoot.progress
            height: parent.height - (parent.border.width * 2)
            color: Colors.primary
            radius: parent.radius
            x: parent.border.width
            y: parent.border.width

            Behavior on width {
                NumberAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }
    }
}
