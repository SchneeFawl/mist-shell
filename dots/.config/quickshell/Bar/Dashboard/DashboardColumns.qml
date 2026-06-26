import QtQuick.Layouts
import QtQuick
import "./components"
import "./components/QuickControls"
import "./widgets"
import "./calendar"
import qs.modules.theme

RowLayout {
    id: dashboardColumnsLayout

    property int activeTab: 1           // defaults to media mode
    property bool active: false

    spacing: Variables.dashInnerColSpacing
    anchors.margins: 16
    anchors.fill: parent
    clip: true

    // navigation panel
    ColumnRectangle {
        Layout.preferredWidth: 50
        color: "transparent"

        NavPanel {
            onTabSelected: (index) => dashboardColumnsLayout.activeTab = index
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

        MainContent {
            activeTab: dashboardColumnsLayout.activeTab
        }
    }

    // quick controls
    ColumnRectangle {
        id: quickControls
        Layout.preferredWidth: 280
        color: "transparent"

        property string columnState: "default"

        // container
        Item {
            anchors.fill: parent
            clip: true

            // quick control btns + calendar
            ColumnLayout {
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                spacing: Variables.dashInnerColSpacing
                x: quickControls.columnState === "default" ? 0 : -parent.width

                Behavior on x {
                    NumberAnimation {
                        duration: 280
                        easing.type: Easing.OutCubic
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "transparent"

                    QuickControls {
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
                        duration: 280
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }

    // slider controls
    ColumnRectangle {
        Layout.preferredWidth: 50
        color: Colors.surface_container_low

        SliderControls {}
    }
}
