import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.theme
import qs.modules.common
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

                StyledText {
                    Layout.fillHeight: true
                    font.pixelSize: Variables.fontNormal
                    color: Colors.primary
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
        pillSpacing: Variables.spacingSmall

        MouseArea {     // audio control
            Layout.preferredWidth: Math.round(24 * Variables.scaleFactor)
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconSmall
                color: Colors.primary
                text: Icons.sysVolume
            }
            onClicked: Quickshell.execDetached(["pavucontrol"]);
        }

        MouseArea {     // power actions
            Layout.preferredWidth: Math.round(24 * Variables.scaleFactor)
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            StyledText {
                anchors.centerIn: parent
                monospace: true
                font.pixelSize: Variables.iconSmall
                color: Colors.error
                text: Icons.powerIcon
            }
            onClicked: console.log("trigger custom power actions")
        }
    }
}
