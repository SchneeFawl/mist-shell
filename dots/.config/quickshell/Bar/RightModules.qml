import QtQuick
import QtQuick.Layouts
import Quickshell

RowLayout {
    spacing: variables.pillOuterSpacing

    // system tray (placeholder for now)
    Pill {
        innerPadding: variables.pillInnerPadding
        SystemTray {}
    }

    // clock display widget
    Pill {
        innerPadding: variables.pillInnerPadding
        pillSpacing: 6

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var d = new Date();
                timeDisplay.text = d.toLocaleTimeString(Qt.locale(), "hh:mm AP");
                dateDisplay.text = Qt.formatDate(d, "dd/M");
                dayDisplay.text = Qt.formatDate(d, "dddd");
            }
        }

        BarText {
            id: timeDisplay
        }
        // BarText { text: "•"; color: themePalette.textSub; Layout.alignment: Qt.AlignCenter }
        BarText {
            id: dayDisplay
            isSubText: true
        }
        BarText {
            id: dateDisplay
            isSubText: true
        }
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
            onClicked: { Quickshell.execDetached(["nm-connection-editor"]) }
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
            onClicked: { Quickshell.execDetached(["pavucontrol"]) }
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

