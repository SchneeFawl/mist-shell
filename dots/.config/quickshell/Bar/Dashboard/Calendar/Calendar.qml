import QtQuick
import QtQuick.Layouts
import "calendar.js" as CalendarLogic

Rectangle {
    id: root

    property int currentYear: new Date().getFullYear()
    property int currentMonth: new Date().getMonth()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: themePalette.pillBorder      // qmllint disable
    radius: 14

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        property int fixedRadius: 14 - 5

        // month container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            radius: parent.fixedRadius
        }

        // weekday container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            radius: parent.fixedRadius

            RowLayout {
                anchors.fill: parent
                Layout.alignment: Qt.AlignHCenter
                anchors.margins: 4
                spacing: 4

                Text { text: "S"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "M"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "T"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "W"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "T"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "F"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
                Text { text: "S"; font.family: "Maple Mono Normal"; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter }
            }
        }

        // bg for calendar grid (dates)
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: parent.fixedRadius

            GridLayout {
                anchors.fill: parent
                anchors.margins: 4
                columns: 7
                rowSpacing: 4
                columnSpacing: 4

                Repeater {
                    model: CalendarLogic.getDaysForGrid(root.currentYear, root.currentMonth)
                    delegate: Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: themePalette.pillBorder      // qmllint disable unqualified
                        radius: 5

                        Text {
                            anchors.centerIn: parent
                            color: modelData.isCurrentMonth ? themePalette.textVibrant : themePalette.textSub
                            text: modelData.day
                        }
                    }
                }
            }
        }
    }
}
