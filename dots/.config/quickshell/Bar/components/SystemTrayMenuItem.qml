pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme

Item {
    id: menuItem

    required property var customMenuPopup
    required property var modelData
    required property int index
    readonly property bool isHighlighted: parentMenu && parentMenu.highlightedIndex === index
    property bool submenuOpen: false
    property var parentMenu: null
    signal popped()

    Layout.fillWidth: true
    implicitWidth: (modelData?.isSeparator ?? false) ? 0 : contentRow.childrenRect.width + contentRow.leftPadding + 20
    implicitHeight: (modelData?.isSeparator ?? false) ? 6 : 28

    Connections {
        target: menuItem.parentMenu
        function onVisibleChanged() {
            if (menuItem.parentMenu !== null) {
                if (!menuItem.parentMenu.visible) {
                    menuItem.submenuOpen = false;
                }
            }
        }
    }

    function triggerItem() {
        let menuData = menuItem.modelData;
        if (menuData.isSeparator) return;

        if (menuData.hasChildren) {
            menuItem.customMenuPopup.openSubmenu(menuData);
            return;
        }

        menuData.triggered();
        menuItem.popped();
        menuItem.customMenuPopup.close();
    }

    // hover rectangle
    Rectangle {
        id: menuItemRect
        anchors.fill: parent
        color: Colors.surface_container_high
        radius: Variables.pillRadius - 8
        visible: true
        opacity: (
            (delegateMouseHandler.containsMouse || menuItem.isHighlighted) && !menuItem.modelData.isSeparator
            ) ? 1.0 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 100
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    // separator line
    Rectangle {
        visible: menuItem.modelData?.isSeparator ?? false
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 1
        color: Colors.border_variant
    }

    // (icon + text) layout
    Row {
        id: contentRow
        spacing: menuItemText.leftPadding
        leftPadding: 4
        anchors.verticalCenter: parent.verticalCenter

        Item {
            visible: menuItem.modelData?.buttonType > 0 ?? false
            anchors.verticalCenter: parent.verticalCenter
            height: 16
            width: 16

            // modelData.buttonType [ None = 0, checkbox = 1, radiobutton = 2 ]
            // Qt.Checkstate (modelData.checkState) [ unchecked = 0, partially = 1, checked = 2 ]

            // CheckBox
            Rectangle {
                visible: menuItem.modelData?.buttonType === 1 ?? false
                anchors.verticalCenter: parent.verticalCenter
                height: 16
                width: 16
                border.width: 1
                border.color: menuItem.modelData?.checkState === 0 ? Colors.inverse_primary : Colors.primary ?? ""
                radius: 4
                color: menuItem.modelData?.checkState === 0 ? "transparent" : Colors.surface_bright ?? ""

                Text {
                    anchors.centerIn: parent
                    visible: menuItem.modelData?.checkState !== 0 ?? false
                    text: menuItem.modelData?.checkState === 1 ? Icons.minus : Icons.checkMark ?? ""
                    color: Colors.primary
                    font.pixelSize: Variables.fontSmall
                    font.bold: true
                    font.family: Variables.defaultFontFamily
                }
            }

            // RadioButton
            Rectangle {
                visible: menuItem.modelData?.buttonType === 2 ?? false
                anchors.verticalCenter: parent.verticalCenter
                height: 16
                width: 16
                border.width: 1
                border.color: Colors.surface_bright
                radius: 4
                color: menuItem.modelData?.checkState === 2 ? Colors.primary : Colors.inactiveAccent ?? ""

                Rectangle {
                    visible: menuItem.modelData?.checkState === 2 ?? false
                    height: 12
                    width: 12
                    radius: 4
                    color: Colors.activeAccent
                }
            }
        }

        IconImage {
            id: menuItemIcon
            source: menuItem.modelData?.icon ?? ""
            visible: menuItem.modelData?.icon ?? false
            implicitSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }

        // menu item text
        Text {
            id: menuItemText
            visible: !menuItem.modelData?.isSeparator ?? false
            anchors.verticalCenter: parent.verticalCenter
            text: menuItem.modelData?.text ?? ""
            font.pixelSize: Variables.fontSmall
            font.family: Variables.defaultFontFamily
            color: Colors.on_primary_container
            leftPadding: 4
        }
    }

    Text {
        id: submenuArrow
        visible: menuItem.modelData ? !menuItem.modelData.isSeparator && menuItem.modelData.hasChildren : false
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        text: Icons.chevronRight
        color: Colors.on_primary_container
        font.pixelSize: Variables.fontSmall
        font.family: Variables.defaultFontFamily
        opacity: 0.7
    }

    // move events handler for the menu items
    MouseArea {
        id: delegateMouseHandler
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton

        onClicked: (mouse) => {
            let menuData = menuItem.modelData

            if (menuData.isSeparator) {
                return;
            }

            if (menuData.hasChildren) {
                menuItem.customMenuPopup.openSubmenu(menuData);
                return;
            }

            menuData.triggered();
            menuItem.popped();
            menuItem.customMenuPopup.close();
        }

        onEntered: {
            if (menuItem.parentMenu.activeSubmenu && menuItem.parentMenu.activeSubmenu !== menuItem) {
                menuItem.parentMenu.activeSubmenu.submenuOpen = false;
            }
            // if (menuItem.modelData.hasChildren) {
            //     submenuHoverTimer.start();
            // }
        }
    }
}
