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
    implicitWidth: (modelData?.isSeparator ?? false) ? 0 : (
        contentRow.childrenRect.width + contentRow.leftPadding + Math.round(20 * Variables.scaleFactor)
    )
    implicitHeight: (modelData?.isSeparator ?? false) ? 6 * (Variables.scaleFactor) : Math.round(28 * Variables.scaleFactor)

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
        radius: Variables.radiusSmall
        visible: true
        opacity: ((delegateMouseHandler.containsMouse || menuItem.isHighlighted) && !menuItem.modelData.isSeparator) ? 1.0 : 0

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
        height: Math.round(1 * Variables.scaleFactor)
        color: Colors.border_variant
    }

    // (icon + text) layout
    Row {
        id: contentRow
        spacing: menuItemText.leftPadding
        leftPadding: Variables.spacingSmall
        anchors.verticalCenter: parent.verticalCenter

        Item {
            visible: menuItem.modelData?.buttonType > 0 ?? false
            anchors.verticalCenter: parent.verticalCenter
            height: Variables.buttonHeightSmallest
            width: height

            // modelData.buttonType [ None = 0, checkbox = 1, radiobutton = 2 ]
            // Qt.Checkstate (modelData.checkState) [ unchecked = 0, partially = 1, checked = 2 ]

            // CheckBox
            Rectangle {
                visible: menuItem.modelData?.buttonType === 1 ?? false
                anchors.verticalCenter: parent.verticalCenter
                height: Variables.buttonHeightSmallest
                width: height
                border.width: 1
                border.color: menuItem.modelData?.checkState === 0 ? Colors.inverse_primary : Colors.primary ?? ""
                radius: Variables.radiusSmall
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
                height: Variables.buttonHeightSmallest
                width: Variables.buttonHeightSmallest
                border.width: 1
                border.color: Colors.surface_bright
                radius: Variables.radiusSmall
                color: menuItem.modelData?.checkState === 2 ? Colors.primary : Colors.inactiveAccent ?? ""

                Rectangle {
                    visible: menuItem.modelData?.checkState === 2 ?? false
                    height: Math.round(12 * Variables.scaleFactor)
                    width: height
                    radius: Math.round(4 * Variables.scaleFactor)
                    color: Colors.activeAccent
                }
            }
        }

        IconImage {
            id: menuItemIcon
            source: menuItem.modelData?.icon ?? ""
            visible: menuItem.modelData?.icon ?? false
            implicitSize: Variables.iconSmall
            anchors.verticalCenter: parent.verticalCenter
        }

        // menu item text
        Text {
            id: menuItemText
            visible: !menuItem.modelData?.isSeparator ?? false
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Variables.fontSmall
            font.family: Variables.defaultFontFamily
            color: Colors.on_primary_container
            text: menuItem.modelData?.text ?? ""
            leftPadding: Variables.spacingSmall
        }
    }

    Text {
        id: submenuArrow
        visible: menuItem.modelData ? !menuItem.modelData.isSeparator && menuItem.modelData.hasChildren : false
        anchors.right: parent.right
        anchors.rightMargin: Variables.spacingLarge
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Variables.fontNormal
        font.family: Variables.defaultFontFamily
        color: Colors.on_primary_container
        text: Icons.chevronRight
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
        }
    }
}
