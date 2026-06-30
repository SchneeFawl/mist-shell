pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.modules.theme

PopupWindow {
    id: customMenuPopup

    required property var trayIcon
    property var trayModelData

    function openSubmenu(handle) {
        stackView.push(subMenuComponent.createObject(null, { handle: handle, isSubMenu: true }))
    }

    function close() { visible = false; }

    anchor {
        item: trayIcon
        edges: Edges.Bottom | Edges.Left        // qmllint disable missing-type
        gravity: Edges.Bottom | Edges.Right     // qmllint disable missing-type
    }
    visible: false
    color: "transparent"
    implicitWidth: menuItemWrapper.width
    implicitHeight: menuItemWrapper.height
    grabFocus: true

    property var activeSubmenu: null
    readonly property var menuWindows: {
        let list = [ customMenuPopup ];
        let current = customMenuPopup;
        while (current && current.activeSubmenu) {
            let win = current.activeSubmenu.submenuWindow;
            if (win) {
                list.push(win);
                current = win;
            } else break;
        }
        return list;
    }

    WrapperRectangle {
        id: menuItemWrapper

        readonly property int targetHeight: stackView.currentItem ? stackView.currentItem.implicitHeight + 16 : 0
        readonly property int targetWidth: stackView.currentItem ? stackView.currentItem.implicitWidth + 16 : 0

        anchors.left: parent.left
        anchors.top: parent.top
        width: customMenuPopup.visible ? targetWidth : 1
        height: customMenuPopup.visible ? targetHeight : 1
        color: Colors.surface_container_low
        radius: 8
        border.color: Colors.border
        border.width: 1
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

        Component { id: subMenuComponent; SubMenu {} }

        StackView {
            id: stackView
            anchors.fill: parent
            anchors.margins: 8

            pushEnter: Transition { NumberAnimation { duration: 0 } }
            pushExit: Transition { NumberAnimation { duration: 0 } }
            popEnter: Transition { NumberAnimation { duration: 0 } }
            popExit: Transition { NumberAnimation { duration: 0 } }

            initialItem: SubMenu {
                handle: customMenuPopup.trayModelData?.menu ?? null
            }

            component SubMenu: ColumnLayout {
                id: submenu
                spacing: 2

                required property var handle
                property bool isSubMenu: false

                QsMenuOpener {
                    id: submenuOpener
                    menu: submenu.handle
                }

                Repeater {
                    model: submenuOpener.children
                    delegate: SystemTrayMenuItem {
                        customMenuPopup: customMenuPopup
                        parentMenu: submenu
                    }
                }
            }
        }
    }
}
