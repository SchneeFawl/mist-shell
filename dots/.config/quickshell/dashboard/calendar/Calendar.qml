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
    radius: Variables.dashColumnRadius

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Variables.spacingSmall

        property int fixedRadius: Variables.dashColumnRadius - Variables.spacingSmaal

        // month container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            radius: parent.fixedRadius
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Variables.spacingMedium
                anchors.rightMargin: Variables.spacingMedium

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

                Item { Layout.fillWidth: true }     // filler

                // month and year label
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Variables.fontMedium
                    font.bold: true
                    text: {
                        var months = ["January", "February", "March", "April", "May",
                            "June", "July", "August", "September", "October", "November", "December"];
                        return months[root.currentMonth] + " " + root.currentYear;
                    }
                    scale: labelMouseArea.pressed ? 0.85 : 1.0

                    MouseArea {
                        id: labelMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.currentMonth = new Date().getMonth();
                            root.currentYear = new Date().getFullYear();
                        }
                    }
                }

                Item { Layout.fillWidth: true }     // filler

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
                        required property int index
                        readonly property bool isTodayWeekDay: {
                            root.currentMonth === new Date().getMonth() && root.currentYear === new Date().getFullYear() && index === new Date().getDay();
                        }

                        required property string modelData
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Variables.fontSmall
                        color: isTodayWeekDay ? Colors.primary : Colors.on_surface
                        font.weight: isTodayWeekDay ? Variables.defaultFontWeight + 200 : Variables.defaultFontWeight
                        text: modelData
                    }
                }
            }
        }

        // bg for calendar grid (dates)
        Rectangle {
            id: gridBg

            readonly property int activeWeekRow: {
                let days = CalendarLogic.getDaysForGrid(root.currentYear, root.currentMonth);
                let idx = days.findIndex(d => d.isToday);
                return idx >= 0 ? Math.floor(idx / 7) : -1;
            }
            readonly property int rowHeight: (height - (Variables.spacingSmall * 2) - (Variables.spacingSmall * 5)) / 6
            readonly property Item targetWeekItem: {
                if (gridBg.activeWeekRow >= 0 && gridRepeater.count > gridBg.activeWeekRow * 7) {
                    return gridRepeater.itemAt(gridBg.activeWeekRow * 7);
                }
                return null;
            }

            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: parent.fixedRadius
            color: Colors.surface_container_high

            Rectangle {
                id: weekBg

                x: Variables.spacingSmall
                y: gridBg.targetWeekItem ? (gridBg.targetWeekItem.y + Variables.spacingSmall) : 0
                width: parent.width - (Variables.spacingSmall * 2)
                height: gridBg.targetWeekItem?.height ?? 0
                radius: height / 2
                color: Colors.surface_container_highest
                visible: gridBg.activeWeekRow >= 0
            }

            GridLayout {
                anchors.fill: parent
                anchors.margins: Variables.spacingSmall
                columns: 7
                rowSpacing: Variables.spacingSmall
                columnSpacing: Variables.spacingSmall

                Repeater {
                    id: gridRepeater
                    model: CalendarLogic.getDaysForGrid(root.currentYear, root.currentMonth)
                    delegate: Item {
                        id: dateContainer
                        required property var modelData

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            anchors.fill: parent
                            radius: width / 2
                            color: dateContainer.modelData.isToday ? Colors.primary : "transparent"

                            StyledText {
                                anchors.centerIn: parent
                                color: {
                                    dateContainer.modelData.isToday ? Colors.on_primary : (
                                        dateContainer.modelData.isCurrentMonth ? Colors.secondary : Colors.tertiary
                                    )
                                }
                                font.bold: dateContainer.modelData.isToday ? Variables.defaultFontWeight + 200 : Variables.defaultFontWeight
                                text: dateContainer.modelData.day
                            }
                        }
                    }
                }
            }
        }
    }
}
