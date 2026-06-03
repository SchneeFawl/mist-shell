import QtQml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell.Hyprland

// qmllint disable unqualified

RowLayout {
    id: trayRoot
    spacing: 8

    property var activePopup: null

    Connections {
        target: Hyprland

        function onFocusedWorkspaceChanged() {
            if (trayRoot.activePopup !== null) {
                trayRoot.activePopup.visible = false;
                trayRoot.activePopup = null;
            }
        }
        
        function onActiveToplevelChanged() {
            if (trayRoot.activePopup !== null) {
                trayRoot.activePopup.visible = false;
                trayRoot.activePopup = null;
            }
        }
    }

    Repeater {
        model: SystemTray.items

        delegate: IconImage {
            id: trayIcon
            source: modelData.icon
            implicitSize: modelData.status != "Passive" ? 18 : 0
            visible: modelData.status != "Passive" ? true : false

            HyprlandFocusGrab {
                active: customMenuPopup.visible
                windows: [ customMenuPopup ]
                onCleared: customMenuPopup.visible = false
            }

            PopupWindow {
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
                    menu: modelData.menu
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

                            delegate: Text {
                                text: modelData.text
                                font.pixelSize: 12
                                color: themePalette.textMain

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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        modelData.activate();
                    }
                    if (mouse.button == Qt.RightButton) {
                        if (modelData.hasMenu) {
                            // closing the previous popup if a diff one is clicked
                            if (trayRoot.activePopup && trayRoot.activePopup !== customMenuPopup) {
                                trayRoot.activePopup.visible = false;
                            }

                            customMenuPopup.visible = !customMenuPopup.visible;

                            // tracking the currently active popup
                            if (customMenuPopup.visible) {
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
