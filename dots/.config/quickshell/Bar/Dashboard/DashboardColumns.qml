import QtQuick.Layouts
import QtQuick
import "./components"
import "./Calendar"

RowLayout {

    property int activeTab: 1           // defaults to media mode

    id: dashboardColumnsLayout
    spacing: 5
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

    // main content
    ColumnRectangle {
        Layout.fillWidth: true
        color: "transparent"

        MainContent {
            activeTab: dashboardColumnsLayout.activeTab
        }
    }

    ColumnRectangle {
        Layout.fillWidth: true
    }

    // quick controls + calendar
    ColumnRectangle {
        Layout.preferredWidth: 280
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

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

    ColumnRectangle {
        Layout.preferredWidth: 50
    }
}
