import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

Pill {
    id: timePill
    innerPadding: Variables.pillInnerPadding
    pillSpacing: 6

    property bool showFullDate: true

    MouseArea {
        parent: timePill        // bypassing row layout
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: timePill.showFullDate = !timePill.showFullDate
    }

    Row {
        Layout.fillHeight: true
        spacing: 6
        clip: true

        BarText {
            id: timeDisplay
            text: Time.timeText
            anchors.verticalCenter: parent.verticalCenter
        }

        BarText {
            id: dayDisplay
            isSubText: true
            text: Time.dayText
            visible: timePill.showFullDate
            opacity: timePill.showFullDate ? 1.0 : 0.0
            anchors.verticalCenter: parent.verticalCenter

            Behavior on opacity {
                NumberAnimation {
                    duration: 240
                    easing.type: Easing.OutCubic
                }
            }
        }

        BarText {
            id: dateDisplay
            isSubText: true
            text: Time.dateText
            visible: timePill.showFullDate
            opacity: timePill.showFullDate ? 1.0 : 0.0
            anchors.verticalCenter: parent.verticalCenter

            Behavior on opacity {
                NumberAnimation {
                    duration: 240
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
