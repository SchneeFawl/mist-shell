import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Item {
    id: pillRoot

    default property alias pillContent: contentLayout.data
    property color customBorderColor: Colors.border
    property int innerPadding: Variables.pillInnerPadding
    property int pillSpacing: 8

    implicitWidth: contentLayout.implicitWidth + (innerPadding * 2)
    implicitHeight: Variables.pillHeight

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Colors.primary_container
        radius: Variables.pillRadius
        clip: true

        RowLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.leftMargin: pillRoot.innerPadding
            anchors.rightMargin: pillRoot.innerPadding
            spacing: pillRoot.pillSpacing
        }
    }
}
