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
        SystemTray { id: sysTray }
    }

    // clock display widget
    BarTime {}

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
            onClicked: Quickshell.execDetached(["pavucontrol"]);
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
