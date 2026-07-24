pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import qs.modules.theme
import qs.services

Rectangle {
    id: themeDropdown

    property bool expanded: false
    property var themeModel: ThemeController.themeList

    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius
    focus: true

    Popup {
        id: dropdownMenu

        readonly property int btnHeight: Variables.buttonHeight
        readonly property int targetHeight: Math.min(themeDropdown.themeModel.length * btnHeight + 8, btnHeight * 4)

        y: parent.height + 4         // topMargin = 4
        width: parent.width
        height: targetHeight
        opacity: themeDropdown.expanded ? 1.0 : 0.0

        onClosed: themeDropdown.expanded = false
        closePolicy: Popup.CloseOnPressOutside || Popup.CloseOnPressOutsideParent

        background: Rectangle {
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
        }

        enter: Transition {
            NumberAnimation {
                property: "height"
                from: 0; to: dropdownMenu.targetHeight
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
            NumberAnimation {
                property: "opacity"
                duration: Variables.durationMedium
                from: 0; to: 1.0
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "height"
                to: 0
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
            NumberAnimation {
                property: "opacity"
                duration: Variables.durationFast
                to: 0
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
        }

        contentItem: ListView {
            id: themeListView
            anchors.fill: parent
            clip: true
            model: themeDropdown.themeModel

            highlightFollowsCurrentItem: true
            highlightMoveDuration: Variables.durationMedium
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
                height: Variables.buttonHeight

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
                            themeDropdown.expanded = false;
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
        cursorShape: Qt.PointingHandCursor
        onClicked: themeDropdown.expanded = !themeDropdown.expanded
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
            dropdownMenu.open();
            themeDropdown.forceActiveFocus();
            DashboardController.keyboardFocus = true;

            for (let i = 0; i < themeModel.length; i++) {
                if (themeModel[i].name === ThemeController.theme) {
                    themeListView.currentIndex = i;
                    break;
                }
            }
        } else {
            dropdownMenu.close();
            DashboardController.keyboardFocus = false;
        }
    }
}
