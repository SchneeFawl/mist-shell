import QtQuick
import QtQuick.Layouts
import qs.modules.theme

ColumnLayout {
    id: statProgBarRoot

    property string title: ""
    property var progress: 0.0
    property string leftSubText: ""
    property string rightSubText: ""

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.rightMargin: Variables.dashInnerColSpacing
    height: 50
    spacing: Variables.dashInnerColSpacing

    RowLayout {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height
        Layout.leftMargin: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        Text {
            id: titleText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Variables.defaultFontFamily
            font.pixelSize: 14
            color: Colors.on_surface
            text: statProgBarRoot.title
        }

        Rectangle {
            id: sliderRoot
            Layout.preferredWidth: parent.width - titleText.width - (Variables.dashInnerColSpacing * 2)
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
