pragma ComponentBehavior: Bound
import QtQml
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.modules.theme

RowLayout {
    id: trayRoot
    spacing: Variables.spacingNormal

    property var activePopup: null

    Connections {
        target: Hyprland

        function onFocusedWorkspaceChanged() {
            if (trayRoot.activePopup !== null) {
                trayRoot.activePopup.close();
                trayRoot.activePopup = null;
            }
        }

        function onActiveToplevelChanged() {
            if (trayRoot.activePopup !== null) {
                trayRoot.activePopup.close();
                trayRoot.activePopup = null;
            }
        }
    }

    Repeater {
        model: SystemTray.items

        delegate: IconImage {
            id: trayIcon
            required property var modelData

            source: modelData.icon
            implicitSize: modelData.status !== "Passive" ? 18 : 0
            visible: modelData.status !== "Passive" ? true : false

            HyprlandFocusGrab {
                active: customMenuPopup.visible
                windows: customMenuPopup.menuWindows
                onCleared: customMenuPopup.close()
            }

            SystemTrayMenu {
                id: customMenuPopup
                trayIcon: trayIcon
                trayModelData: trayIcon.modelData
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        trayIcon.modelData.activate();
                    }
                    if (mouse.button === Qt.RightButton) {
                        if (trayIcon.modelData.hasMenu) {
                            // closing the previous popup if a diff one is clicked
                            if (trayRoot.activePopup && trayRoot.activePopup !== customMenuPopup) {
                                trayRoot.activePopup.close();
                            }

                            if (customMenuPopup.visible) {
                                customMenuPopup.close();
                            } else {
                                customMenuPopup.open();
                            }

                            // tracking the currently active popup
                            if (customMenuPopup.expanded) {
                                trayRoot.activePopup = customMenuPopup;
                            } else {
                                trayRoot.activePopup = null;
                            }
                        }
                    }
                }
            }
        }
    }
}
