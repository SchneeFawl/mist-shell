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
    Layout.preferredHeight: Variables.buttonHeight
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

        readonly property int targetHeight: (Variables.buttonHeight * 4) + 4

        y: parent.height + 4
        width: parent.width
        height: targetHeight
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

                height: Variables.buttonHeight
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
                        onClicked: {
                            ScreenRecordService.quality = content.modelData;
                            qualityDropdown.expanded = false;
                        }
                    }
                }
            }
        }

        enter: Transition {
            NumberAnimation {
                property: "height"
                from: 0; to: qualityMenu.targetHeight
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
            NumberAnimation {
                property: "opacity"
                from: 0; to: 1.0
                duration: Variables.durationMedium
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
                to: 0
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
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
        cursorShape: Qt.PointingHandCursor
        onClicked: qualityDropdown.expanded = !qualityDropdown.expanded
    }

    Keys.onPressed: (event) => {
        if (!expanded) return;

        if (event.key === Qt.Key_Up) {
            if (qualityView.currentIndex > 0) {
                qualityView.currentIndex--;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Down) {
            if (qualityView.currentIndex < qualityView.count - 1) {
                qualityView.currentIndex++;
            }
            event.accepted = true;
        } else if ([Qt.Key_Enter, Qt.Key_Return].includes(event.key)) {
            ScreenRecordService.quality = qualityView.model[qualityView.currentIndex];
            qualityDropdown.expanded = false;
            event.accepted = true;
        } else if (event.key === Qt.Key_Escape) {
            qualityDropdown.expanded = false;
            event.accepted = true;
        }
    }

    onExpandedChanged: {
        if (expanded) {
            qualityMenu.open();
            qualityDropdown.forceActiveFocus();
            DashboardController.keyboardFocus = true;
        } else {
            qualityMenu.close();
            DashboardController.keyboardFocus = false;
        }
    }
}
