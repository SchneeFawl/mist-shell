pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.modules.theme

Item {
    id: menuItem
    Layout.fillWidth: true
    implicitWidth: (modelData?.isSeparator ?? false) ? 0 : contentRow.implicitWidth + 20
    implicitHeight: (modelData?.isSeparator ?? false) ? 6 : 28

    required property var customMenuPopup
    required property var menuItemDelegate
    property bool submenuOpen: false
    property var parentMenu: null
    property var modelData: null

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

    Loader {
        active: menuItem.modelData ? (menuItem.modelData.hasChildren && menuItem.submenuOpen) : false
        sourceComponent: Component {
            // tray items submenu popup
            PopupWindow {
                id: customSubmenuPopup
                visible: menuItem.submenuOpen
                color: "transparent"
                grabFocus: true
                anchor {
                    item: menuItem
                    edges: Edges.Left | Edges.Top              // qmllint disable missing-type
                    gravity: Edges.Left | Edges.Bottom         // qmllint disable missing-type
                }
                implicitHeight: submenuItemsColumn.implicitHeight + 16
                implicitWidth: submenuItemsColumn.implicitWidth + 16

                QsMenuOpener {
                    id: submenuOpener
                    menu: menuItem.modelData
                }

                WrapperRectangle {
                    id: submenuItemWrapper
                    color: Colors.surface_container_low
                    border.color: Colors.border
                    border.width: 2
                    width: customSubmenuPopup.visible ? parent.width : 0
                    height: customSubmenuPopup.visible ? parent.height : 0
                    radius: 8
                    anchors.left: parent.left
                    anchors.top: parent.top
                    clip: true

                    ColumnLayout {
                        id: submenuItemsColumn
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 2

                        Repeater {
                            model: submenuOpener.children

                            delegate: Loader {
                                required property var modelData

                                sourceComponent: menuItem.menuItemDelegate
                                Layout.fillWidth: true
                                onLoaded: {
                                    item.parentMenu = customSubmenuPopup;
                                    item.modelData = modelData;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // hover rectangle
    Rectangle {
        id: menuItemRect
        visible: true
        opacity: (delegateMouseHandler.containsMouse && !menuItem.modelData.isSeparator) ? 1.0 : 0
        anchors.fill: parent
        color: Colors.surface_container_high
        radius: 8

        Behavior on opacity {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutCubic
            }
        }
    }

    Rectangle {     // separator line
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
            // modelData.buttonType [ None = 0, checkbox = 1, radiobutton = 2 ]
            // Qt.Checkstate (modelData.checkState) [ unchecked = 0, partially = 1, checked = 2 ]
            visible: menuItem.modelData?.buttonType > 0 ?? false
            anchors.verticalCenter: parent.verticalCenter
            height: 16
            width: 16

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
                    font.pixelSize: 12
                    font.bold: true
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
            font.pixelSize: 12
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
        font.pixelSize: 12
        opacity: 0.7
    }

    Timer {
        id: submenuHoverTimer
        interval: 150
        repeat: false
        onTriggered: {
            menuItem.submenuOpen = true;
            menuItem.parentMenu.activeSubmenu = menuItem;
        }
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
                /* do nothing */
            } else if (!menuData.isSeparator && menuData.hasChildren && menuData.buttonType === QsMenuButtonType.None) {
                menuData.triggered();
            } else if (!menuData.isSeparator && !menuData.hasChildren && menuData.buttonType === QsMenuButtonType.None) {
                menuData.triggered();
                menuItem.customMenuPopup.visible = false;
            } else if (!menuData.isSeparator && menuData.buttonType > QsMenuButtonType.None) {
                menuData.triggered();
            }
        }

        onEntered: {
            if (menuItem.parentMenu.activeSubmenu && menuItem.parentMenu.activeSubmenu !== menuItem) {
                menuItem.parentMenu.activeSubmenu.submenuOpen = false;
            }
            if (menuItem.modelData.hasChildren) {
                submenuHoverTimer.start();
            }
        }
        onExited: menuItem.modelData.hasChildren ? submenuHoverTimer.stop() : null
    }
}
