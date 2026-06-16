import QtQuick
import QtQuick.Layouts
import qs.modules.theme

// qmllint disable unqualified

Item {
    id: pillRoot

    // anything inside Pill will go into contentLayout
    default property alias pillContent: contentLayout.data
    property color customBorderColor: Colors.pillBorder
    property int innerPadding: Variables.pillInnerPadding
    property int pillSpacing: 8

    implicitWidth: contentLayout.implicitWidth + (innerPadding * 2)
    implicitHeight: Variables.pillHeight

    Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Colors.pillBackground
        border.width: 0     // no border
        radius: 12
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
