import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Pill {
    id: timePill
    innerPadding: Variables.pillInnerPadding
    pillSpacing: Variables.pillInnerSpacing

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

        StyledText {
            id: timeDisplay
            anchors.verticalCenter: parent.verticalCenter
            color: Colors.primary
            text: Time.timeText
        }

        StyledText {
            id: dayDisplay
            anchors.verticalCenter: parent.verticalCenter
            opacity: timePill.showFullDate ? 1.0 : 0.0
            visible: timePill.showFullDate
            font.pixelSize: Variables.fontSmall
            color: Colors.secondary
            text: Time.dayText

            Behavior on opacity {
                NumberAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }

        StyledText {
            id: dateDisplay
            anchors.verticalCenter: parent.verticalCenter
            visible: timePill.showFullDate
            opacity: timePill.showFullDate ? 1.0 : 0.0
            font.pixelSize: Variables.fontSmall
            color: Colors.secondary
            text: Time.dateText

            Behavior on opacity {
                NumberAnimation {
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }
    }
}
