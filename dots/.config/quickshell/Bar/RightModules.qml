import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import "./components"

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
                dayDisplay.text = Qt.formatDate(d, "dddd");
                dateDisplay.text = Qt.formatDate(d, "dd/M");
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
                text: Icons.sysVolume
                color: Colors.primary
                font.pixelSize: 18
            }
            onClicked: Quickshell.execDetached(["sh", "-c", "pavucontrol"]);
        }

        MouseArea {     // power actions
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: Icons.powerIcon
                color: "#F7768E"
                font.pixelSize: 18
            }
            onClicked: console.log("trigger custom power actions")
        }
    }
}
