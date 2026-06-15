import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme

RowLayout {
    spacing: Variables.pillOuterSpacing

    // system tray
    Pill {
        visible: sysTray.implicitWidth > 0
        innerPadding: visible ? Variables.pillInnerPadding : 0
        SystemTray {
            id: sysTray
        }
    }

    // clock display widget
    Pill {
        innerPadding: Variables.pillInnerPadding
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

        BarText {
            id: dayDisplay
            isSubText: true
        }

        BarText {
            id: dateDisplay
            isSubText: true
        }
    }

    // desktop feature
    Pill {
        innerPadding: 4
        pillSpacing: 2

        MouseArea {     // audio control
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "󰕾"
                color: Colors.activeAccent
                font.pixelSize: 20
            }
            onClicked: {
                Quickshell.execDetached(["pavucontrol"]);
            }
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
