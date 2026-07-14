import QtQuick
import QtQuick.Layouts
import qs.modules.theme

ColumnLayout {
    id: statProgBarRoot

    property string title: ""
    property var progress: 0.0
    property string leftSubText: ""
    property string rightSubText: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 50
    spacing: Variables.dashInnerColSpacing

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.leftMargin: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        Text {
            id: titleText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Variables.defaultFontFamily
            font.pixelSize: 15
            color: Colors.on_surface
            text: statProgBarRoot.title
        }

        Rectangle {
            id: sliderRoot
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            Layout.alignment: Qt.AlignHCenter
            color: Colors.surface_container_high
            border.width: 2
            border.color: Colors.border_variant
            radius: Variables.dashInnerRadius

            Rectangle {
                id: sliderFill
                width: parent.width * statProgBarRoot.progress
                height: parent.height - ((parent.border.width + 2) * 2)
                color: Colors.primary
                radius: parent.radius
                x: parent.border.width + 2
                y: parent.border.width + 2

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

    RowLayout {
        id: subTextLayout
        Layout.preferredWidth: parent.width

        Text {
            id: leftText
            Layout.fillWidth: true
            Layout.leftMargin: Variables.dashInnerColSpacing + 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.family: Variables.defaultFontFamily
            font.pixelSize: 14
            color: Colors.on_surface
            text: statProgBarRoot.leftSubText
            visible: statProgBarRoot.leftSubText !== ""
        }

        Text {
            id: rightText
            Layout.fillWidth: true
            Layout.rightMargin: Variables.dashInnerColSpacing + 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.family: Variables.defaultFontFamily
            font.pixelSize: 14
            color: Colors.on_surface
            text: statProgBarRoot.rightSubText
            visible: statProgBarRoot.rightSubText !== ""
        }
    }
}
