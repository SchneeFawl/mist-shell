pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.modules.theme

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

    Component {
        id: menuItemDelegate

        SystemTrayMenuItem {
            customMenuPopup: customMenuPopup
            menuItemDelegate: menuItemDelegate
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: customMenuPopup.trayModelData.menu
    }

    WrapperRectangle {
        id: menuItemWrapper
        color: Colors.surface_container_low
        border.color: Colors.border
        border.width: 1
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
                    required property var modelData

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
