import Quickshell
import QtQuick
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

        Column {
            id: trayItemsColumn
            anchors.fill: parent
            anchors.margins: 8

            Repeater {
                model: menuOpener.children

                delegate: Item {
                    id: menuItemContainer
                    implicitWidth: modelData.isSeparator ? 0 : menuItemText.implicitWidth + 32
                    implicitHeight: modelData.isSeparator ? 8 : 20

                    // separator line
                    Rectangle {
                        visible: modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        height: 1
                        color: "#45475a"
                    }

                    Text {
                        id: menuItemText
                        visible: !modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.text
                        font.pixelSize: 12
                        color: themePalette.textMain
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton

                        onClicked: mouse => {
                            modelData.triggered();
                            customMenuPopup.visible = false;
                        }
                    }
                }
            }
        }
    }
}