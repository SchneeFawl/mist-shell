import QtQuick
import QtQuick.Layouts

Rectangle {
    id: pillContainer
    // anything inside Pill will go into contentLayout
    default property alias pillContent: contentLayout.data
    property int innerPadding: 12
    property int pillSpacing: 8

    height: 30
    color: themePalette.pillBackground
    border.color: themePalette.pillBorder
    border.width: 1
    radius: 14

    // smooth hover feedback animations
    Behavior on border.color { ColorAnimation { duration: 175 } }

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.leftMargin: pillContainer.innerPadding
        anchors.rightMargin: pillContainer.innerPadding
        spacing: pillContainer.pillSpacing
    }
}
