import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme

// qmllint disable unqualified

PopupWindow {
    id: customMenuPopup

    required property var trayIcon
    property var trayModelData

    anchor {
        item: trayIcon
        edges: Edges.Bottom | Edges.Left        // qmllint disable missing-type
        gravity: Edges.Bottom | Edges.Right     // qmllint disable missing-type
    }
    visible: false
    color: "transparent"
    implicitWidth: trayItemsColumn.implicitWidth + 16
    implicitHeight: trayItemsColumn.implicitHeight + 16
    grabFocus: true

    property var activeSubmenu: null

    // resuable component
    Component {
        id: menuItemDelegate

        Item {
            id: menuItemContainer
            Layout.fillWidth: true
            implicitWidth: (modelData?.isSeparator ?? false) ? 0 : contentRow.implicitWidth + 20
            implicitHeight: (modelData?.isSeparator ?? false) ? 6 : 28

            property bool submenuOpen: false
            property var parentMenu: null
            property var modelData: null

            Connections {
                target: parentMenu
                function onVisibleChanged() {
                    if (parentMenu !== null) {
                        if (!parentMenu.visible) {
                            menuItemContainer.submenuOpen = false;
                        }
                    }
                }
            }

            Loader {
                active: modelData ? (modelData.hasChildren && submenuOpen) : false
                sourceComponent: Component {
                    // tray items submenu popup
                    PopupWindow {
                        id: customSubmenuPopup
                        visible: submenuOpen
                        color: "transparent"
                        grabFocus: true
                        anchor {
                            item: menuItemContainer
                            edges: Edges.Left | Edges.Top              // qmllint disable missing-type
                            gravity: Edges.Left | Edges.Bottom         // qmllint disable missing-type
                        }
                        implicitHeight: submenuItemsColumn.implicitHeight + 16
                        implicitWidth: submenuItemsColumn.implicitWidth + 16

                        QsMenuOpener {
                            id: submenuOpener
                            menu: modelData
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
                                        sourceComponent: menuItemDelegate
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
                opacity: (delegateMouseHandler.containsMouse && !modelData.isSeparator) ? 1.0 : 0
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
                visible: modelData?.isSeparator ?? false
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
                    visible: modelData?.buttonType > 0 ?? false
                    anchors.verticalCenter: parent.verticalCenter
                    height: 16
                    width: 16

                    // CheckBox
                    Rectangle {
                        visible: modelData?.buttonType === 1 ?? false
                        anchors.verticalCenter: parent.verticalCenter
                        height: 16
                        width: 16
                        border.width: 1
                        border.color: modelData?.checkState === 0 ? Colors.inverse_primary : Colors.primary ?? ""
                        radius: 4
                        color: modelData?.checkState === 0 ? "transparent" : Colors.surface_bright ?? ""

                        Text {
                            anchors.centerIn: parent
                            visible: modelData?.checkState !== 0 ?? false
                            text: modelData?.checkState === 1 ? Icons.minus : Icons.checkMark ?? ""
                            color: Colors.primary
                            font.pixelSize: 12
                            font.bold: true
                        }
                    }

                    // RadioButton
                    Rectangle {
                        visible: modelData?.buttonType === 2 ?? false
                        anchors.verticalCenter: parent.verticalCenter
                        height: 16
                        width: 16
                        border.width: 1
                        border.color: Colors.surface_bright
                        radius: 4
                        color: modelData?.checkState === 2 ? Colors.primary : Colors.inactiveAccent ?? ""

                        Rectangle {
                            visible: modelData?.checkState === 2 ?? false
                            height: 12
                            width: 12
                            radius: 4
                            color: Colors.activeAccent
                        }
                    }
                }

                IconImage {
                    id: menuItemIcon
                    source: modelData?.icon ?? ""
                    visible: modelData?.icon ?? false
                    implicitSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }

                // menu item text
                Text {
                    id: menuItemText
                    visible: !modelData?.isSeparator ?? false
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData?.text ?? ""
                    font.pixelSize: 12
                    color: Colors.on_primary_container
                    leftPadding: 4
                }
            }

            Text {
                id: submenuArrow
                visible: modelData ? !modelData.isSeparator && modelData.hasChildren : false
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
                    submenuOpen = true;
                    parentMenu.activeSubmenu = menuItemContainer;
                }
            }

            // move events handler for the menu items
            MouseArea {
                id: delegateMouseHandler
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton

                onClicked: (mouse) => {
                    if (modelData.isSeparator) {
                        /* do nothing */
                    } else if (!modelData.isSeparator && modelData.hasChildren && modelData.buttonType === QsMenuButtonType.None) {
                        modelData.triggered();
                    } else if (!modelData.isSeparator && !modelData.hasChildren && modelData.buttonType === QsMenuButtonType.None) {
                        modelData.triggered();
                        customMenuPopup.visible = false;
                    } else if (!modelData.isSeparator && modelData.buttonType > QsMenuButtonType.None) {
                        modelData.triggered();
                    }
                }

                onEntered: {
                    if (parentMenu.activeSubmenu && parentMenu.activeSubmenu !== menuItemContainer) {
                        parentMenu.activeSubmenu.submenuOpen = false;
                    }
                    if (modelData.hasChildren) {
                        submenuHoverTimer.start();
                    }
                }
                onExited: modelData.hasChildren ? submenuHoverTimer.stop() : null
            }
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: trayModelData.menu
    }

    WrapperRectangle {
        id: menuItemWrapper
        color: Colors.surface_container_low
        border.color: Colors.border
        border.width: 2
        width: customMenuPopup.visible ? parent.width : 0
        height: customMenuPopup.visible ? parent.height : 0
        radius: 8
        anchors.left: parent.left
        anchors.top: parent.top
        clip: true

        Behavior on height {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        ColumnLayout {
            id: trayItemsColumn
            anchors.fill: parent
            anchors.margins: 8
            spacing: 2

            Repeater {
                model: menuOpener.children

                delegate: Loader {
                    sourceComponent: menuItemDelegate
                    Layout.fillWidth: true
                    onLoaded: {
                        item.parentMenu = customMenuPopup;
                        item.modelData = modelData;
                    }
                }
            }
        }
    }
}
