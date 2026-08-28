import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

ColumnLayout {
    id: statProgBarRoot

    property string icon: ""
    property var progress: 0.0
    property string leftSubText: ""
    property string rightSubText: ""

    property color progressColor: Colors.primary
    property color leftSubTextColor: Colors.on_surface
    property color rightSubTextColor: Colors.on_surface
    property string rightIcon: ""
    property color rightIconColor: Colors.on_surface

    Layout.fillWidth: true
    Layout.preferredHeight: Variables.buttonHeightMedium
    spacing: Variables.dashInnerColSpacing

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.leftMargin: Variables.dashInnerColSpacing
        spacing: Variables.dashInnerColSpacing

        StyledText {
            id: icon
            monospace: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Variables.fontMedium
            color: Colors.on_surface
            text: statProgBarRoot.icon
        }

        Rectangle {
            id: progressRoot
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(18 * Variables.scaleFactor)
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

        StyledText {
            id: leftText
            Layout.leftMargin: Variables.dashInnerColSpacing + Math.round(2 * Variables.scaleFactor)
            horizontalAlignment: Text.AlignLeft
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

        StyledText {
            id: rightIcon
            horizontalAlignment: Text.AlignRight
            rightPadding: -Variables.dashInnerColSpacing
            font.pixelSize: Variables.fontMedium
            color: statProgBarRoot.rightIconColor
            text: statProgBarRoot.rightIcon
            visible: statProgBarRoot.rightIcon !== ""
        }

        StyledText {
            id: rightText
            Layout.rightMargin: Variables.dashInnerColSpacing + Math.round(2 * Variables.scaleFactor)
            horizontalAlignment: Text.AlignRight
            color: statProgBarRoot.rightSubTextColor
            text: statProgBarRoot.rightSubText
            visible: statProgBarRoot.rightSubText !== ""
        }
    }
}
