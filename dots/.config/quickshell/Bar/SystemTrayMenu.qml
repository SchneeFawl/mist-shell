import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

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

    QsMenuOpener {
        id: menuOpener
        menu: trayModelData.menu
    }

    WrapperRectangle {
        id: menuItemWrapper
        // anchors.fill: parent
        color: themePalette.pillBackground
        border.color: themePalette.pillBorder
        border.width: 2
        width: customMenuPopup.visible ? parent.width : 0
        height: customMenuPopup.visible ? parent.height : 0
        radius: 8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        clip: true

        Behavior on height {
            NumberAnimation {
                duration: 150
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.38, 0.8, 0.22, 1, 1, 1]  // material ui curve
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: 150
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.38, 0.8, 0.22, 1, 1, 1]
            }
        }

        ColumnLayout {
            id: trayItemsColumn
            anchors.fill: parent
            anchors.margins: 8
            spacing: 2

            Repeater {
                model: menuOpener.children

                delegate: Item {
                    id: menuItemContainer
                    Layout.fillWidth: true
                    implicitWidth: modelData.isSeparator ? 0 : menuItemText.implicitWidth + 20
                    implicitHeight: modelData.isSeparator ? 6 : 28

                    property bool submenuOpen: false

                    Connections {
                        target: customMenuPopup
                        function onVisibleChanged() {
                            if (!customMenuPopup.visible) {
                                menuItemContainer.submenuOpen = false;
                            }
                        }
                    }

                    Loader {
                        active: modelData.hasChildren && submenuOpen
                        sourceComponent: Component {
                            // tray items submenu popup
                            PopupWindow {
                                visible: submenuOpen
                                color: "transparent"
                                grabFocus: false
                                anchor {
                                    item: menuItemContainer
                                    edges: Edges.Right | Edges.Top              // qmllint disable missing-type
                                    gravity: Edges.Right | Edges.Bottom         // qmllint disable missing-type
                                }

                                QsMenuOpener {
                                    id: submenuOpener
                                    menu: modelData.hasChildren ? modelData : null
                                }

                                Rectangle {
                                    visible: true
                                    width: 50
                                    height: 50
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
                        color: '#21212d'
                        radius: menuItemWrapper.radius

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Rectangle {     // separator line
                        visible: modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        height: 1
                        color: "#45475a"
                    }

                    // (icon + text) layout
                    Row {
                        spacing: menuItemText.leftPadding
                        leftPadding: 4                      // 4+4=8
                        anchors.verticalCenter: parent.verticalCenter

                        Item {
                            // modelData.buttonType [ None = 0, checkbox = 1, radiobutton = 2 ]
                            // Qt.Checkstate (modelData.checkState) [ unchecked = 0, partially = 1, checked = 2 ]
                            visible: modelData.buttonType > 0
                            anchors.verticalCenter: parent.verticalCenter
                            height: 16
                            width: 16

                            // CheckBox
                            Rectangle {
                                visible: modelData.buttonType === 1
                                anchors.verticalCenter: parent.verticalCenter
                                height: 16
                                width: 16
                                border.width: 1
                                border.color: modelData.checkState === 0 ? themePalette.inactiveAccent : themePalette.activeAccent
                                radius: 4
                                color: modelData.checkState === 0 ? "transparent" : themePalette.pillBorder

                                Text {
                                    anchors.centerIn: parent
                                    visible: modelData.checkState !== 0
                                    text: modelData.checkState === 1 ? "\u2212" : "\u2713"  // "-" and "{tick}"
                                    color: themePalette.activeAccent
                                    font.pixelSize: 10
                                    font.bold: true
                                }
                            }

                            // RadioButton
                            Rectangle {
                                visible: modelData.buttonType === 2
                                anchors.verticalCenter: parent.verticalCenter
                                height: 16
                                width: 16
                                border.width: 1
                                border.color: themePalette.pillBorder
                                radius: 4
                                color: modelData.checkState === 2 ? themePalette.activeAccent : themePalette.inactiveAccent

                                Rectangle {
                                    visible: modelData.checkState === 2
                                    height: 12
                                    width: 12
                                    radius: 4
                                    color: themePalette.activeAccent
                                }
                            }
                        }

                        IconImage {
                            id: menuItemIcon
                            source: modelData.icon
                            visible: modelData.icon ? true : false
                            implicitSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // menu item text
                        Text {
                            id: menuItemText
                            visible: !modelData.isSeparator
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.text
                            font.pixelSize: 12
                            color: themePalette.textMain
                            leftPadding: 4
                        }
                    }

                    Text {
                        id: submenuArrow
                        visible: !modelData.isSeparator && modelData.hasChildren
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        text: "›"
                        color: themePalette.textMain
                        font.pixelSize: 18
                        opacity: 0.7
                    }

                    Timer {
                        id: submenuHoverTimer
                        interval: 150
                        repeat: false
                        onTriggered: {
                            submenuOpen = true;
                            customMenuPopup.activeSubmenu = menuItemContainer;
                        }
                    }

                    // move events handler for the menu items
                    MouseArea {
                        id: delegateMouseHandler
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton

                        onClicked: mouse => {
                            if (modelData.isSeparator) {
                                /*  can put customMenuPopup.visible = true; but its
                                    not necessary since it stays true anyways */
                            } else if (!modelData.isSeparator && modelData.buttonType === QsMenuButtonType.None) {
                                modelData.triggered();
                                customMenuPopup.visible = false;
                            } else if (!modelData.isSeparator && modelData.buttonType > QsMenuButtonType.None) {
                                modelData.triggered();
                            }
                        }

                        onEntered: {
                            if (customMenuPopup.activeSubmenu && customMenuPopup.activeSubmenu !== menuItemContainer) {
                                customMenuPopup.activeSubmenu.submenuOpen = false;
                            }
                            if (modelData.hasChildren) {
                                submenuHoverTimer.start();
                            }
                        }
                        onExited: modelData.hasChildren ? submenuHoverTimer.stop() : null
                    }
                }
            }
        }
    }
}
