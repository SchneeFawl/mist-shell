import QtQuick
import QtQuick.Layouts
import "calendar.js" as CalendarLogic
import qs.modules.theme

// qmllint disable unqualified

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
            Layout.preferredHeight: 36
            radius: parent.fixedRadius
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                PrevMonthButton {
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
                    font.pixelSize: 15
                    font.family: Variables.defaultFontFamily
                    font.bold: true

                    text: {
                        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        return months[root.currentMonth] + " " + root.currentYear;
                    }
                }

                NextMonthButton {
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

                Text {
                    text: "S"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "M"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "T"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "W"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "T"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "F"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
                }
                Text {
                    text: "S"
                    font.family: Variables.defaultFontFamily
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_surface
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
                    delegate: Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: Colors.surface_container_high
                        radius: 5

                        Text {
                            anchors.centerIn: parent
                            color: modelData.isCurrentMonth ? Colors.primary : Colors.on_surface
                            text: modelData.day
                            font.family: Variables.defaultFontFamily
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }
    }
}
