pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
// import qs.services
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

        SettingsSearchBar {}

        // separator
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(2 * Variables.scaleFactor)
            Layout.topMargin: Variables.spacingSmall
            Layout.bottomMargin: Variables.spacingSmall
            Layout.leftMargin: Variables.spacingLarge
            Layout.rightMargin: Variables.spacingLarge
            color: Colors.border_variant
            radius: height / 2
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: Variables.spacingSmall
            clip: true

            model: root.pages
            delegate: Rectangle {
                id: card
                required property var modelData
                required property int index

                implicitWidth: parent.width
                implicitHeight: Variables.buttonHeight
                color: root.currentPage === index ? Colors.primary : "transparent"
                radius: Variables.radiusNormal
                scale: cardMouseArea.pressed ? 0.90 : 1.0

                Row {
                    anchors.fill: parent
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: Variables.spacingMedium
                    spacing: Variables.spacingNormal

                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        monospace: true
                        font.pixelSize: Variables.iconNormal
                        color: root.currentPage === card.index ? Colors.on_primary : Colors.on_surface
                        text: card.modelData.icon
                    }

                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: Variables.fontMedium
                        color: root.currentPage === card.index ? Colors.on_primary : Colors.on_surface
                        text: card.modelData.name
                    }
                }

                MouseArea {
                    id: cardMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.currentPage = card.index
                }

                Behavior on color {
                    ColorAnimation {
                        duration: Variables.durationMedium
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: Variables.durationFast
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }
            }
        }
    }
}

