import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12
    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

    Pill {
        innerPadding: 12
        BarText {      // temp representation
            text: "󰅟 󰋋 󱚽"
            font.pixelSize: 18
            Layout.alignment: Qt.AlignVCenter
        }
    }

    // clock display widget
    Pill {
        innerPadding: 12
        pillSpacing: 6

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var d = new Date()
                timeDisplay.text = d.toLocaleTimeString(Qt.locale(), "hh:mm AP")
                dateDisplay.text = Qt.formatDate(d, "dd/M")
                dayDisplay.text = Qt.formatDate(d, "dddd")
            }
        }

        BarText { id: timeDisplay; Layout.alignment: Qt.AlignCenter }
        // BarText { text: "•"; color: themePalette.textSub; Layout.alignment: Qt.AlignCenter }
        BarText { id: dayDisplay; isSubText: true; Layout.alignment: Qt.AlignCenter }
        BarText { id: dateDisplay; isSubText: true; Layout.alignment: Qt.AlignCenter }
    }

    // core desktop feature handlers
    Pill {
        innerPadding: 4
        pillSpacing: 2

        MouseArea {     // network
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "󰖩"
                color: themePalette.activeAccent
                font.pixelSize: 20
            }
            onClicked: console.log("run: nm-connection-editor")
        }

        MouseArea {     // audio control
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "󰕾"
                color: themePalette.activeAccent
                font.pixelSize: 20
            }
            onClicked: console.log("run: pavucontrol")
        }

        MouseArea {     // power actions dashboard
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "⏻"
                color: "#F7768E"
                font.pixelSize: 20
            }
            onClicked: console.log("trigger custom power actions")
        }
    }
}
