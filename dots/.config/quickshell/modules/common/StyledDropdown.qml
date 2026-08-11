pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import qs.modules.theme

Rectangle {
    id: root

    property bool expanded: false

    property var model: []
    property var delegateText

    property string selectedText: ""
    property color selectedTextColor: Colors.on_surface

    signal delegateClicked(var itemData, int index)
    signal returnPressed()

    implicitHeight: Variables.buttonHeightMedium
    implicitWidth: Math.round(120 * Variables.scaleFactor)
    color: Colors.surface_container_high
    radius: Variables.radiusNormal
    focus: true

    Popup {
        id: dropdownMenu

        readonly property int btnHeight: Variables.buttonHeight
        readonly property int targetHeight: Math.min(root.model.length * btnHeight + 8, btnHeight * 4)

        y: parent.height + Variables.spacingSmall         // topMargin = 4
        width: parent.width
        height: targetHeight
        opacity: root.expanded ? 1.0 : 0.0

        onClosed: root.expanded = false
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
            id: listView
            anchors.fill: parent
            clip: true
            model: root.model

            highlightFollowsCurrentItem: true
            highlightMoveDuration: Variables.durationMedium
            highlight: Item {
                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: Variables.spacingSmall
                    anchors.rightMargin: Variables.spacingSmall
                    anchors.topMargin: Variables.spacingSmall
                    color: Colors.primary
                    radius: Variables.radiusNormal - Variables.spacingSmall
                }
            }

            delegate: Item {
                id: modelDelegate

                required property var modelData
                required property int index

                width: listView.width
                height: Variables.buttonHeight

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: Variables.spacingSmall
                    anchors.rightMargin: Variables.spacingSmall
                    anchors.topMargin: Variables.spacingSmall
                    color: "transparent"
                    radius: Variables.radiusNormal - Variables.spacingSmall

                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: Variables.spacingNormal
                        color: modelDelegate.index === listView.currentIndex ? Colors.on_primary : Colors.on_surface
                        text: String(modelDelegate.modelData)
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            root.delegateClicked(modelDelegate.modelData, modelDelegate.index);
                            root.expanded = false;
                        }
                        onEntered: listView.currentIndex = modelDelegate.index
                    }
                }
            }
        }
    }

    StyledText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: Variables.spacingMedium
        color: root.selectedTextColor
        text: root.selectedText
    }

    StyledText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.leftMargin: Variables.spacingMedium
        anchors.rightMargin: Variables.spacingMedium
        font.pixelSize: Variables.iconNormal
        text: Icons.chevronDown
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.expanded = !root.expanded
    }

    Keys.onPressed: event => {
        if (!expanded) return;

        if (event.key === Qt.Key_Down) {
            if (listView.currentIndex < listView.count - 1) {
                listView.currentIndex++;
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Up) {
            if (listView.currentIndex > 0) {
                listView.currentIndex--;
            }
            event.accepted = true;
        } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
            returnPressed();
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
            root.forceActiveFocus();
            // DashboardController.keyboardFocus = true;
        } else {
            dropdownMenu.close();
            // DashboardController.keyboardFocus = false;
        }
    }
}
