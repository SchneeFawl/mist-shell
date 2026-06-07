import QtQuick.Layouts
import QtQuick
import "./components"

RowLayout {

    property int activeTab

    id: dashboardColumnsLayout
    spacing: 5
    anchors.margins: 16
    anchors.fill: parent
    clip: true

    ColumnRectangle {
        Layout.preferredWidth: 50
        color: "transparent"

        NavPanel {
            onTabSelected: (index) => dashboardColumnsLayout.activeTab = index
        }
    }

    ColumnRectangle {
        Layout.fillWidth: true
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
