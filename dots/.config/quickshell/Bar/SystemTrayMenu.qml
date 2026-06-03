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
        anchors.fill: parent
        color: themePalette.pillBackground
        border.color: themePalette.pillBorder
        border.width: 2
        radius: 8
        margin: { left: 5 }

        ColumnLayout {
            id: trayItemsColumn
            anchors.fill: parent
            anchors.margins: 8

            Repeater {
                model: menuOpener.children

                delegate: Item {
                    id: menuItemContainer
                    Layout.fillWidth: true
                    implicitWidth: modelData.isSeparator ? 0 : menuItemText.implicitWidth + 20
                    implicitHeight: modelData.isSeparator ? 8 : 20

                    Rectangle {     // separator line
                        visible: modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        height: 1
                        color: "#45475a"
                    }

                    RowLayout {
                        spacing: 8

                        IconImage {
                            id: menuItemIcon
                            source: modelData.icon
                            visible: modelData.icon ? true : false
                            implicitSize: 14
                            Layout.alignment: Qt.AlignVCenter
                        }

                        Text {         // menu item text
                            id: menuItemText
                            visible: !modelData.isSeparator
                            Layout.alignment: Qt.AlignVCenter   // might not be necessary
                            text: modelData.text
                            font.pixelSize: 12
                            color: themePalette.textMain
                        }
                    }

                    MouseArea {       // click handler for the menu items
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
                    }
                }
            }
        }
    }
}