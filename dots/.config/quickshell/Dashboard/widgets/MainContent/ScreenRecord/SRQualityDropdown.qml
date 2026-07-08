pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.modules.theme
import qs.services

Rectangle {
    id: qualityDropdown

    property bool expanded: false

    Layout.fillWidth: true
    Layout.preferredHeight: 36
    Layout.leftMargin: Variables.dashInnerColSpacing
    Layout.rightMargin: Variables.dashInnerColSpacing
    color: Colors.surface_container_high
    radius: Variables.dashInnerRadius
    focus: true

    function formatQualityName(name) {
        if (name === "very_high") return "Very High";
        return name.charAt(0).toUpperCase() + name.slice(1);
    }

    Popup {
        id: qualityMenu

        y: parent.height + 4
        width: parent.width
        height: (36 * 4) + 4
        opacity: qualityDropdown.expanded ? 1.0 : 0

        closePolicy: Popup.CloseOnPressOutside || Popup.CloseOnPressOutsideParent
        onClosed: qualityDropdown.expanded = false

        background: Rectangle {
            color: Colors.surface_container_high
            radius: Variables.dashInnerRadius
        }

        contentItem: ListView {
            id: qualityView
            anchors.fill: parent
            clip: true

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

            model: ["medium", "high", "very_high", "ultra"]
            delegate: Item {
                id: content
                required property var modelData
                required property int index

                height: 36
                width: qualityMenu.width

                Rectangle {
                    id: textContainer
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    color: "transparent"
                    radius: Variables.dashInnerRadius - 4

                    ScreenRecordText {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 12
                        font.family: Variables.defaultFontFamily
                        color: content.index === qualityView.currentIndex ? Colors.on_primary : Colors.on_surface
                        text: qualityDropdown.formatQualityName(content.modelData)

                        Behavior on color {
                            ColorAnimation {
                                duration: Variables.durationFast
                                easing.type: Easing.Bezier
                                easing.bezierCurve: Variables.standardCurve
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: qualityView.currentIndex = content.index
                    }
                }
            }
        }
    }

    ScreenRecordText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 12
        font.family: Variables.defaultFontFamily
        color: Colors.on_surface
        text: qualityDropdown.formatQualityName(ScreenRecordService.quality)
    }

    ScreenRecordText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        font.family: Variables.defaultFontFamily
        color: Colors.on_surface
        size: 20
        text: Icons.chevronDown
    }

    MouseArea {
        anchors.fill: parent
        onClicked: qualityDropdown.expanded = !qualityDropdown.expanded
    }

    onExpandedChanged: {
        if (expanded) {
            qualityMenu.open();
            qualityMenu.forceActiveFocus();
            DashboardController.keyboardFocus = true;
        } else {
            qualityMenu.close();
            DashboardController.keyboardFocus = false;
        }
    }
}
