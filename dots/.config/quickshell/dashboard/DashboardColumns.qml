import QtQuick.Layouts
import QtQuick
import "./components"
import "./components/QuickControls"
import "./widgets"
import "./calendar"
import qs.modules.theme
import qs.services

RowLayout {
    id: dashboardColumnsLayout

    property bool active: DashboardController.active

    spacing: Variables.dashInnerColSpacing
    anchors.margins: Variables.spacingLarge
    anchors.fill: parent
    clip: true

    // navigation panel
    ColumnRectangle {
        Layout.preferredWidth: Variables.buttonHeightMedium
        color: "transparent"

        NavPanel {
            onTabSelected: (index) => DashboardController.activeTab = index
        }
    }

    // notifications
    ColumnRectangle {
        Layout.fillWidth: true
        color: Colors.surface_container_low

        NotificationsList { active: dashboardColumnsLayout.active }
    }

    // main content
    ColumnRectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"

        MainContent {}
    }

    // quick controls
    ColumnRectangle {
        id: quickControls
        Layout.preferredWidth: Math.round(280 * Variables.scaleFactor)
        color: "transparent"

        property string columnState: "default"

        // container
        Item {
            anchors.fill: parent
            clip: true

            // quick controls + calendar
            ColumnLayout {
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                spacing: Variables.dashInnerColSpacing
                x: quickControls.columnState === "default" ? 0 : -parent.width

                Behavior on x {
                    NumberAnimation {
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.exitCurve
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: quickControlsWidget.implicitHeight
                    color: "transparent"

                    QuickControls {
                        id: quickControlsWidget
                        onBluetoothRightClicked: quickControls.columnState = "bluetooth"
                    }
                }

                Calendar {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }

            BluetoothPanel {
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: quickControls.columnState === "bluetooth" ? 0 : parent.width

                onBackClicked: quickControls.columnState = "default"

                Behavior on x {
                    NumberAnimation {
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.entranceCurve
                    }
                }
            }
        }
    }

    // slider controls
    ColumnRectangle {
        Layout.preferredWidth: Variables.buttonHeightMedium
        color: Colors.surface_container_low

        SliderControls {}
    }
}
