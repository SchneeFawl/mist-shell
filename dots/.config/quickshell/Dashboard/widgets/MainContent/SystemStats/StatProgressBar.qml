import QtQuick
import QtQuick.Layouts
import qs.modules.theme

ColumnLayout {
    id: statProgBarRoot

    property string title: ""
    property var progress: 0.0
    property string leftSubText: ""
    property string rightSubText: ""

    property color progressColor: Colors.primary
    property color leftSubTextColor: Colors.on_surface
    property color rightSubTextColor: Colors.on_surface
    property string rightIcon: ""
    property color rightIconColor: Colors.on_surface

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
            id: progressRoot
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            Layout.alignment: Qt.AlignHCenter
            color: Colors.surface_container_high
            border.width: 2
            border.color: Colors.border_variant
            radius: Variables.dashInnerRadius

            Rectangle {
                id: progressFill
                width: parent.width * statProgBarRoot.progress
                height: parent.height - ((parent.border.width + 2) * 2)
                color: statProgBarRoot.progressColor
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
        Layout.fillWidth: true

        Text {
            id: leftText
            Layout.leftMargin: Variables.dashInnerColSpacing + 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontNormal
            color: statProgBarRoot.leftSubTextColor
            text: statProgBarRoot.leftSubText
            visible: statProgBarRoot.leftSubText !== ""
        }

        Rectangle {
            Layout.preferredHeight: 2
            Layout.fillWidth: true
            color: Colors.surface_container_highest
            radius: Variables.dashInnerRadius
        }

        Text {
            id: rightIcon
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: -Variables.dashInnerColSpacing
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontMedium
            color: statProgBarRoot.rightIconColor
            text: statProgBarRoot.rightIcon
            visible: statProgBarRoot.rightIcon !== ""
        }

        Text {
            id: rightText
            Layout.rightMargin: Variables.dashInnerColSpacing + 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.family: Variables.defaultFontFamily
            font.pixelSize: Variables.fontNormal
            color: statProgBarRoot.rightSubTextColor
            text: statProgBarRoot.rightSubText
            visible: statProgBarRoot.rightSubText !== ""
        }
    }
}
