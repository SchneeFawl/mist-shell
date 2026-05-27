import QtQuick
import QtQuick.Layouts

Item {
    id: pillRoot
    
    // anything inside Pill will go into contentLayout

    default property alias pillContent: contentLayout.data
    property int innerPadding: 14
    property int pillSpacing: 8
    property color customBorderColor: themePalette.pillBorderr

    implicitWidth: contentLayout.implicitWidth + (innerPadding * 2)
    implicitHeight: 32

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: themePalette.pillBackground
        border.color: pillRoot.customBorderColor
        border.width: 1
        radius: 10

        Behavior on border.color { ColorAnimation { duration: 175 } }
    }

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.leftMargin: pillContainer.innerPadding
        anchors.rightMargin: pillContainer.innerPadding
        spacing: pillRoot.pillSpacing
    }
}
