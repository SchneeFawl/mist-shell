pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.theme
import qs.services

Rectangle {
    id: root

    // general, display, appearance, bar
    property string currentCategory: "general"
    readonly property var pages: [
        {
            name: "General",
            icon: Icons.sliders,
            component: "pages/GeneralSettings.qml",
            keywords: ["font", "general", "monospaced", "family"]
        },
        {
            name: "Display",
            icon: Icons.monitor,
            component: "pages/DisplaySettings.qml",
            keywords: ["display", "monitor", "resolution", "scale", "scaling"]
        },
        {
            name: "Appearance",
            icon: Icons.palette,
            component: "pages/AppearanceSettings.qml",
            keywords: ["appearance", "radius", "spacing", "space", "font size", "fontsize"]
        },
        {
            name: "Bar",
            icon: Icons.dockTop,
            component: "pages/BarSettings.qml",
            keywords: ["bar", "pill", "fragment", "workspace", "radius", "margin", "spacing", "characters", "media", "max"]
        }
    ]
    property int currentPage: 0

    readonly property var filteredPages: {
        if (SettingsService.searchText.trim() === "")
            return pages;
        let query = SettingsService.searchText.toLowerCase();
        return pages.filter(p => p.name.toLowerCase().includes(query) || (p.keywords && p.keywords.some(k => k.toLowerCase().includes(query))));
    }

    Layout.preferredWidth: Math.round(200 * Variables.scaleFactor)
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout {
        id: contentColumn

        anchors.fill: parent
        spacing: Variables.spacingNormal

        SettingsSearchBar {}

        StyledSeparator {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(2 * Variables.scaleFactor)
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: Variables.spacingSmall
            clip: true

            model: root.filteredPages
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

        Item {
            Layout.fillHeight: true
        }

        Rectangle {
            id: resetCard
            property bool showConfirm: false

            Layout.fillWidth: true
            Layout.preferredHeight: Variables.buttonHeight
            color: resetMouseArea.pressed ? Colors.error_container : Colors.error
            radius: Variables.radiusNormal
            scale: resetMouseArea.pressed ? 0.90 : 1.0

            Row {
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: Variables.spacingMedium
                spacing: Variables.spacingNormal
                opacity: resetCard.showConfirm ? 0.0 : 1.0

                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    monospace: true
                    font.pixelSize: Variables.iconNormal
                    color: resetMouseArea.pressed ? Colors.on_error_container : Colors.on_error
                    text: Icons.restoreDefault
                }
                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Variables.fontMedium
                    color: resetMouseArea.pressed ? Colors.on_error_container : Colors.on_error
                    text: "Reset to Defaults"
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationFast
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }
            }

            StyledText {
                anchors.centerIn: parent
                opacity: resetCard.showConfirm ? 1.0 : 0.0
                font.pixelSize: Variables.fontMedium
                color: resetMouseArea.pressed ? Colors.on_error_container : Colors.on_error
                text: "Are you sure?"

                Behavior on opacity {
                    NumberAnimation {
                        duration: Variables.durationFast
                        easing.type: Easing.Bezier
                        easing.bezierCurve: Variables.standardCurve
                    }
                }
            }

            MouseArea {
                id: resetMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (!resetCard.showConfirm) {
                        resetCard.showConfirm = !resetCard.showConfirm;
                        confirmTimer.start();
                    } else {
                        SettingsService.resetToDefaults();
                        resetCard.showConfirm = false;
                    }
                }
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

            Timer {
                id: confirmTimer
                interval: 3500
                running: false
                repeat: false
                onTriggered: resetCard.showConfirm = false
            }
        }
    }
}
