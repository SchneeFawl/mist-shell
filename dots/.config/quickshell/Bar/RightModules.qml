import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 10
    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

    Pill {
        innerPadding: 14
        BarText { text: "󰅟 󰋋 󱚽"; font.pixelSize: 20 }   // temp representation
        Layout.alignment: Qt.AlignHCenter
    }

    // clock display widget
    Pill {
        innerPadding: 0

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

        BarText { id: timeDisplay }
        BarText { text: "•"; color: themePalette.textSub }
        BarText { id: dayDisplay; text: "Monday"; isSubText: true }
        BarText { id: dateDisplay; text: "00/0"; isSubText: true }
    }

    // core desktop feature handlers
    Pill {
        innerPadding: 8
        pillSpacing: 0

        MouseArea {     // network
            Layout.preferredWidth: 28
            Layout.fillHeight: true
            BarText {
                anchors.centerIn: parent
                text: "󰖩"
                color: themePalette.activeAccent
                font.pixelSize: 20
            }
            onClicked: console.log("run: nm-connection-editor")
        }

        MouseArea {     // audio control
            Layout.preferredWidth: 28
            Layout.fillHeight: true
            BarText {
                anchors.centerIn: parent
                text: "󰕾"
                color: themePalette.activeAccent
                font.pixelSize: 20
            }
            onClicked: console.log("run: pavucontrol")
        }

        MouseArea {     // power actions dashboard
            Layout.preferredWidth: 28
            Layout.fillHeight: true
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
