import QtQuick
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themePalette.pillBorder      // qmllint disable
    radius: 12

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            radius: 7
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            radius: 7
        }

        Rectangle {         // background wrapper for the grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 7

            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                flow: GridLayout.LeftToRight
                columns: 7
                rowSpacing: 4
                columnSpacing: 4
            }
        }
    }
}
