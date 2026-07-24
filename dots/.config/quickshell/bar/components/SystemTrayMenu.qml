pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.modules.theme

PopupWindow {
    id: customMenuPopup

    required property var trayIcon
    property var trayModelData
    property bool expanded: false
    property var activeSubmenu: null

    function openSubmenu(handle) {
        stackView.push(subMenuComponent.createObject(null, { handle: handle, isSubMenu: true }))
    }

    function open() {
        closeTimer.stop();
        visible = true;
        expanded = true;
    }

    function close() {
        expanded = false;
        closeTimer.start();
    }

    Timer {
        id: closeTimer
        interval: Variables.durationMedium
        onTriggered: {
            customMenuPopup.visible = false;
            while (stackView.depth > 1) {
                stackView.pop();
            }
        }
    }

    anchor {
        item: trayIcon
        edges: Edges.Bottom | Edges.Left        // qmllint disable missing-type
        gravity: Edges.Bottom | Edges.Right     // qmllint disable missing-type
    }
    visible: false
    color: "transparent"
    implicitWidth: menuItemWrapper.targetWidth
    implicitHeight: menuItemWrapper.targetHeight
    grabFocus: false

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

    HyprlandFocusGrab {
        id: focusGrab
        windows: customMenuPopup.menuWindows
        active: customMenuPopup.visible && customMenuPopup.expanded

        onCleared: customMenuPopup.close()
    }

    WrapperRectangle {
        id: menuItemWrapper

        readonly property int targetHeight: stackView.currentItem?.implicitHeight + Variables.spacingLarge ?? 0
        readonly property int targetWidth: stackView.currentItem?.implicitWidth + Variables.spacingLarge ?? 0

        anchors.left: parent.left
        anchors.top: parent.top
        width: customMenuPopup.expanded ? targetWidth : 1 * Variables.scaleFactor
        height: customMenuPopup.expanded ? targetHeight : 1 * Variables.scaleFactor
        color: Colors.surface_container_low
        radius: Variables.pillRadius
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
            anchors.margins: Variables.spacingNormal
            focus: true

            pushEnter: Transition {
                NumberAnimation {
                    properties: "x"
                    from: menuItemWrapper.targetWidth
                    to: 0
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.entranceCurve
                }
            }
            pushExit: Transition {
                NumberAnimation {
                    properties: "x"
                    from: 0
                    to: -menuItemWrapper.targetWidth
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.exitCurve
                }
            }
            popEnter: Transition {
                NumberAnimation {
                    properties: "x"
                    from: -menuItemWrapper.targetWidth
                    to: 0
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.entranceCurve
                }
            }
            popExit: Transition {
                NumberAnimation {
                    properties: "x"
                    from: 0
                    to: menuItemWrapper.targetWidth
                    duration: Variables.durationMedium
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.exitCurve
                }
            }

            initialItem: SubMenu {
                handle: customMenuPopup.trayModelData?.menu ?? null
            }

            component SubMenu: ColumnLayout {
                id: submenu
                width: stackView.width
                height: stackView.height
                spacing: Variables.spacingSmall

                required property var handle
                property bool isSubMenu: false
                property int highlightedIndex: -1

                QsMenuOpener {
                    id: submenuOpener
                    menu: submenu.handle
                }

                SysTrayBackBtn {
                    visibility: submenu.isSubMenu
                    onClicked: stackView.pop()
                    highlighted: submenu.highlightedIndex === -1
                }

                Rectangle {
                    visible: submenu.isSubMenu
                    Layout.fillWidth: true
                    color: Colors.border_variant
                    Layout.preferredHeight: 1
                }

                Repeater {
                    id: repeater
                    model: submenuOpener.children
                    delegate: SystemTrayMenuItem {
                        customMenuPopup: customMenuPopup
                        parentMenu: submenu
                        onPopped: stackView.pop()
                    }
                }

                function navigateDown() {
                    let count = repeater.count;
                    let idx = highlightedIndex;
                    let startIdx = submenu.isSubMenu ? -1 : 0;

                    for (let i = 0; i < count + 1; i++) {
                        idx += 1;
                        if (idx >= count) idx = startIdx;

                        if (idx === -1) {
                            highlightedIndex = -1;
                            return;
                        }

                        let item = repeater.itemAt(idx);
                        if (item && !item.modelData.isSeparator) {          // qmllint disable missing-property
                            highlightedIndex = idx;
                            return;
                        }
                    }
                }

                function navigateUp() {
                    let count = repeater.count;
                    let idx = highlightedIndex;
                    let startIdx = submenu.isSubMenu ? -1 : 0;

                    for (let i = 0; i < count + 1; i++) {
                        idx -= 1;
                        if (idx >= count) idx = count - 1;

                        if (idx === -1) {
                            highlightedIndex = -1;
                            return;
                        }

                        let item = repeater.itemAt(idx);
                        if (item && !item.modelData.isSeparator) {              // qmllint disable missing-property
                            highlightedIndex = idx;
                            return;
                        }
                    }
                }

                function triggerActive() {
                    if (highlightedIndex === -1 && submenu.isSubMenu) {
                        stackView.pop();
                    } else if (highlightedIndex >= 0 && highlightedIndex < repeater.count) {
                        let item = repeater.itemAt(highlightedIndex);
                        if (item) item.triggerItem();               // qmllint disable missing-property
                    }
                }
            }

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Escape) {
                    customMenuPopup.close();
                    event.accepted = true;
                    return;
                }

                let currentSubmenu = stackView.currentItem;
                if (!currentSubmenu) return;

                if (event.key === Qt.Key_Down) {
                    currentSubmenu.navigateDown();      // qmllint disable missing-property
                    event.accepted = true;
                } else if (event.key === Qt.Key_Up) {
                    currentSubmenu.navigateUp();        // qmllint disable missing-property
                    event.accepted = true;
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    // Qt.callLater(() => { currentSubmenu.triggerActive(); });
                    currentSubmenu.triggerActive();     // qmllint disable missing-property
                    event.accepted = true;
                }
            }
        }
    }
}
