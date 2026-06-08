import QtQuick
import QtQuick.Layouts

Rectangle {
    property int rootWidth: (controlsLayout.rectSize * 4) + (35)

    color: themePalette.pillBorder
    implicitHeight: 80
    implicitWidth: rootWidth
    radius: 24
    anchors.horizontalCenter: parent.horizontalCenter
    clip: true

    RowLayout {
        id: controlsLayout
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        // anchors.topMargin: 5
        // anchors.bottomMargin: 5
        spacing: 5

        property int rectSize: 60

        Rectangle {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            color: "white"
            radius: 12
        }

        Rectangle {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            color: "white"
            radius: 12
        }

        Rectangle {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            color: "white"
            radius: 12
        }

        Rectangle {
            implicitHeight: controlsLayout.rectSize
            implicitWidth: controlsLayout.rectSize
            color: "white"
            radius: 12
        }
    }
}