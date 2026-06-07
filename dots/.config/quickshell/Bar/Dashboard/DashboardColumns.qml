import QtQuick.Layouts
import QtQuick
import "./components"

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

    ColumnRectangle {
        Layout.fillWidth: true
    }

    ColumnRectangle {
        Layout.preferredWidth: 50
    }
}
