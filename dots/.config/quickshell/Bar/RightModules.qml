import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import qs.services
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

    // battery indicator (!! NOT TESTED !!)
    Loader {
        active: Battery.hasBattery
        visible: Battery.hasBattery
        sourceComponent: Component {
            Pill {
                innerPadding: visible ? Variables.pillInnerPadding : 0

                BarText {
                    Layout.fillHeight: true
                    font.pixelSize: Variables.fontNormal
                    text: {
                        let icon = (Battery.isCharging || Battery.isPluggedIn) ? Icons.batteryCharging : (
                            Battery.getBatteryIcon(Battery.batPercentage)
                        );
                        return icon + " " + Math.round(Battery.batPercentage) + "%";
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }

    // desktop feature
    Pill {
        innerPadding: Variables.spacingSmall
        pillSpacing: 0

        MouseArea {     // audio control
            implicitWidth: 30
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: Icons.sysVolume
                color: Colors.primary
                font.pixelSize: Variables.fontMedium
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
                font.pixelSize: Variables.fontMedium
            }
            onClicked: console.log("trigger custom power actions")
        }
    }
}
