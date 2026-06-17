import QtQuick.Layouts
import QtQuick
import "./components"
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
        color: Colors.border

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

    // quick controls + calendar
    ColumnRectangle {
        Layout.preferredWidth: 280
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent
            spacing: Variables.dashInnerColSpacing

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80      // only one row of controls
                color: "transparent"
                QuickControls {}
            }

            Calendar {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }

    }

    // slider controls
    ColumnRectangle {
        Layout.preferredWidth: 50
        color: Colors.border

        SliderControls {}
    }
}
