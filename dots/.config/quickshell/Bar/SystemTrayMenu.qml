import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

PopupWindow {
    required property var trayIcon
    required property var trayModelData

    id: customMenuPopup
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

    QsMenuOpener {
        id: menuOpener
        menu: trayModelData.menu
    }

    WrapperRectangle {
        id: menuItemWrapper
        //anchors.fill: parent
        color: themePalette.pillBackground
        border.color: themePalette.pillBorder
        border.width: 2
        width: visible ? parent.width : 0
        height: visible ? parent.height : 0
        radius: 8
        margin: { left: 5 }
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
                easing.bezierCurve: [0.34, 0.8, 0.22, 1, 1, 1]
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

                    Rectangle {     // hover rectangle
                        id: menuItemRect
                        visible: true
                        opacity: (delegateMouseHandler.containsMouse && !modelData.isSeparator) ? 1.0 : 0
                        anchors.fill: parent
                        color: '#21212d'
                        radius: menuItemWrapper.radius

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
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

                    Row {     // (icon + text) layout
                        spacing: menuItemText.leftPadding
                        leftPadding: 4                      // 4+4=8
                        anchors.verticalCenter: parent.verticalCenter

                        IconImage {
                            id: menuItemIcon
                            source: modelData.icon
                            visible: modelData.icon ? true : false
                            implicitSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {       // menu item text
                            id: menuItemText
                            visible: !modelData.isSeparator
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.text
                            font.pixelSize: 12
                            color: themePalette.textMain
                            leftPadding: 4
                        }
                    }

                    MouseArea {       // move events handler for the menu items
                        id: delegateMouseHandler
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton

                        onClicked: mouse => {
                            if (modelData.isSeparator) {
                                /*  can put customMenuPopup.visible = true; but its
                                    not necessary since it stays true anyways */
                            }
                            else if (!modelData.isSeparator) {
                                modelData.triggered();
                                customMenuPopup.visible = false;
                            }
                        }

                        // onEntered: {
                        //     if (!modelData.isSeparator && containsMouse) {
                        //         menuItemRect.visible = true
                        //     }
                        // }
                        // onExited: menuItemRect.visible = false
                    }
                }
            }
        }
    }
}
