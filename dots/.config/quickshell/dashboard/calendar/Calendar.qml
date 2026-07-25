import QtQuick
import QtQuick.Layouts
import "calendar.js" as CalendarLogic
import qs.modules.theme
import qs.modules.common

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

                BaseButton {
                    btnSize: Variables.buttonHeightSmall
                    radius: width / 2
                    icon: Icons.chevronLeft
                    iconSize: Variables.iconNormal
                    onClicked: {
                        if (root.currentMonth === 0) {
                            root.currentMonth = 11;
                            root.currentYear--;
                        } else {
                            root.currentMonth--;
                        }
                    }
                }

                // month and year label
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Variables.fontMedium
                    font.bold: true
                    text: {
                        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        return months[root.currentMonth] + " " + root.currentYear;
                    }
                }

                BaseButton {
                    btnSize: Variables.buttonHeightSmall
                    radius: width / 2
                    icon: Icons.chevronRight
                    iconSize: Variables.iconNormal
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
            Layout.preferredHeight: Math.round(26 * Variables.scaleFactor)
            radius: parent.fixedRadius
            color: Colors.surface_container_high

            RowLayout {
                anchors.fill: parent
                Layout.alignment: Qt.AlignHCenter
                anchors.margins: Variables.spacingSmall
                spacing: Variables.spacingSmall

                Repeater {
                    model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

                    delegate: StyledText {
                        required property string modelData
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Variables.fontSmall
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
                anchors.margins: Variables.spacingSmall
                columns: 7
                rowSpacing: Variables.spacingSmall
                columnSpacing: Variables.spacingSmall

                Repeater {
                    model: CalendarLogic.getDaysForGrid(root.currentYear, root.currentMonth)
                    delegate: Item {
                        id: dateContainer
                        required property var modelData

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            anchors.fill: parent
                            radius: width / 2
                            color: {
                                dateContainer.modelData.isToday ? Colors.primary : (
                                    dateContainer.modelData.isCurrentWeek ? Colors.surface_container_highest : "transparent"
                                )
                            }

                            StyledText {
                                anchors.centerIn: parent
                                color: {
                                    dateContainer.modelData.isToday ? Colors.on_primary : (
                                        dateContainer.modelData.isCurrentMonth ? Colors.secondary : Colors.tertiary
                                    )
                                }
                                font.bold: dateContainer.modelData.isToday ? true : false
                                text: dateContainer.modelData.day
                            }
                        }
                    }
                }
            }
        }
    }
}
