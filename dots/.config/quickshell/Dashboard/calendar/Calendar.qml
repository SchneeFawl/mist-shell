import QtQuick
import QtQuick.Layouts
import "calendar.js" as CalendarLogic
import qs.modules.theme


Rectangle {
    id: root

    property int currentYear: new Date().getFullYear()
    property int currentMonth: new Date().getMonth()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: Colors.surface_container_low
    radius: 14

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        property int fixedRadius: 14 - 5

        // month container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            radius: parent.fixedRadius
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                CalendarButton {
                    icon: Icons.chevronLeft
                    onClicked: {
                        if (root.currentMonth === 0) {
                            root.currentMonth = 11;
                            root.currentYear--;
                        } else {
                            root.currentMonth--;
                        }
                    }
                }

                // month and year lable
                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                    font.pixelSize: Variables.fontMedium
                    font.family: Variables.defaultFontFamily
                    font.bold: true

                    text: {
                        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        return months[root.currentMonth] + " " + root.currentYear;
                    }
                }

                CalendarButton {
                    icon: Icons.chevronRight
                    onClicked: {
                        if (root.currentMonth === 11) {
                            root.currentMonth = 0;
                            root.currentYear++;
                        } else {
                            root.currentMonth++;
                        }
                    }
                }
            }
        }

        // weekday container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            radius: parent.fixedRadius
            color: Colors.surface_container_high

            RowLayout {
                anchors.fill: parent
                Layout.alignment: Qt.AlignHCenter
                anchors.margins: 4
                spacing: 4

                Repeater {
                    model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

                    delegate: Text {
                        required property string modelData
                        font.family: Variables.defaultFontFamily
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: Colors.on_surface
                        text: modelData
                    }
                }
            }
        }

        // bg for calendar grid (dates)
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: parent.fixedRadius
            color: Colors.surface_container_high

            GridLayout {
                anchors.fill: parent
                anchors.margins: 4
                columns: 7
                rowSpacing: 4
                columnSpacing: 4

                Repeater {
                    model: CalendarLogic.getDaysForGrid(root.currentYear, root.currentMonth)
                    delegate: Item {
                        id: dateContainer
                        required property var modelData

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Text {
                            anchors.centerIn: parent
                            color: dateContainer.modelData.isCurrentMonth ? Colors.primary : Colors.on_surface
                            text: dateContainer.modelData.day
                            font.family: Variables.defaultFontFamily
                            font.pixelSize: Variables.fontNormal
                        }
                    }
                }
            }
        }
    }
}
