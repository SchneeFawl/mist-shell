import QtQuick
import QtQuick.Layouts

Item {
    id: pillRoot
    // anything inside Pill will go into contentLayout
    default property alias pillContent: contentLayout.data
    property int innerPadding: 14
    property int pillSpacing: 8
    property color customBorderColor: themePalette.pillBorder

    implicitWidth: contentLayout.implicitWidth + (innerPadding * 2)
    implicitHeight: 32

    Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: themePalette.pillBackground
        border.width: 0     // no border
        radius: 12

        // Behavior on border.color { ColorAnimation { duration: 175 } }

        RowLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.leftMargin: pillRoot.innerPadding
            anchors.rightMargin: pillRoot.innerPadding
            spacing: pillRoot.pillSpacing
        }
    }
}
