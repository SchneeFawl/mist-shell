import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.theme

Rectangle {
    id: root

    // general, display, appearance, bar
    property string currentCategory: "general"
    readonly property var pages: [
        {
            name: "General",
            icon: Icons.sliders,
            component: "pages/GeneralSettings.qml"
        },
        {
            name: "Display",
            icon: Icons.monitor,
            component: "pages/DisplaySettings.qml"
        },
        {
            name: "Appearance",
            icon: Icons.palette,
            component: "pages/AppearanceSettings.qml"
        },
        {
            name: "Bar",
            icon: Icons.dockTop,
            component: "pages/BarSettings.qml"
        }
    ]
    property int currentPage: 0

    Layout.preferredWidth: Math.round(250 * Variables.scaleFactor)
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout {
        id: contentColumn

        anchors.fill: parent
        spacing: Variables.spacingNormal

        Item { Layout.fillHeight: true }        // filler
    }
}

