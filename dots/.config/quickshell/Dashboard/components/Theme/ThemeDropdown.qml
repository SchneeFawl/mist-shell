pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import qs.modules.theme
import qs.services

Rectangle {
    id: dropdown

    property bool expanded: false
    property var themeModel: ThemeController.themeList

    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius
    focus: true

    Popup {
        id: dropdownMenu
        y: parent.height + 4         // topMargin = 4
        width: parent.width
        height: dropdown.expanded ? Math.min(dropdown.themeModel.length * 36 + 8, 36 * 4) : 0
        visible: height > 0

        onClosed: dropdown.expanded = false
        closePolicy: Popup.CloseOnPressOutside || Popup.CloseOnPressOutsideParent

        background: Rectangle {
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
        }

        onVisibleChanged: {
            if (!visible) {
                ThemeController.keyboardFocus = false;
                dropdown.expanded = false;
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        contentItem: ListView {
            id: themeListView
            anchors.fill: parent
            clip: true
            model: dropdown.themeModel

            highlightFollowsCurrentItem: true
            highlightMoveDuration: 260
            highlight: Item {
                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    color: Colors.primary
                    radius: Variables.dashInnerRadius - 4
                }
            }

            delegate: Item {
                id: themeDelegate

                required property var modelData
                required property int index

                width: themeListView.width
                height: 36

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    color: "transparent"
                    radius: Variables.dashInnerRadius - 4

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 8
                        color: themeDelegate.index === themeListView.currentIndex ? Colors.on_primary : Colors.on_surface
                        font.family: Variables.defaultFontFamily
                        font.pixelSize: 14
                        text: themeDelegate.modelData.name

                        Behavior on color {
                            ColorAnimation {
                                duration: Variables.durationFast
                                easing.type: Easing.Bezier
                                easing.bezierCurve: Variables.standardCurve
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            let targetTheme = themeDelegate.modelData.name;
                            let targetWallpapers = themeDelegate.modelData.wallpapers;
                            let firstWallpaper = (targetWallpapers && targetWallpapers.length > 0) ? targetWallpapers[0] : "";

                            ThemeController.updateState(targetTheme, firstWallpaper, ThemeController.mode)
                            dropdown.expanded = false;
                        }
                        onEntered: themeListView.currentIndex = themeDelegate.index
                    }
                }
            }
        }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 8 + 4
        font.family: Variables.defaultFontFamily
        font.pixelSize: 14
        color: Colors.on_surface
        text: ThemeController.theme
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dropdown.expanded = !dropdown.expanded
    }

    Keys.onPressed: event => {
        if (!expanded) return;

        if (event.key === Qt.Key_Down) {
            if (themeListView.currentIndex < themeListView.count - 1) {
                themeListView.currentIndex++;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Up) {
            if (themeListView.currentIndex > 0) {
                themeListView.currentIndex--;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            let selectedItem = themeModel[themeListView.currentIndex];

            if (selectedItem) {
                let targetTheme = selectedItem.name;
                let targetWallpapers = selectedItem.wallpapers;
                let firstWallpaper = (targetWallpapers && targetWallpapers.length > 0) ? targetWallpapers[0] : "";

                ThemeController.updateState(targetTheme, firstWallpaper, ThemeController.mode);
            }
            expanded = false;
            event.accepted = true;
        } else if (event.key === Qt.Key_Escape) {
            expanded = false;
            event.accepted = true;
        }
    }

    onExpandedChanged: {
        if (expanded) {
            dropdown.forceActiveFocus();
            ThemeController.keyboardFocus = true;

            for (let i = 0; i < themeModel.length; i++) {
                if (themeModel[i].name === ThemeController.theme) {
                    themeListView.currentIndex = i;
                    break;
                }
            }
        } else {
            ThemeController.keyboardFocus = false;
        }
    }
}
