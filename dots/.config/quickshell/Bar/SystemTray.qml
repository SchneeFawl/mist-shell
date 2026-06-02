import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell

RowLayout {
    spacing: 8

    Repeater {
        model: SystemTray.items

        delegate: IconImage {
            id: trayIcon
            source: modelData.icon
            width: 18
            height: 18

            QsMenuAnchor {
                id: menuAnchor
                menu: modelData.menu        // qmllint disable unqualified
                anchor {
                    item: trayIcon
                    edges: Edges.Bottom | Edges.Left        // qmllint disable missing-type
                    gravity: Edges.Bottom | Edges.Right     // qmllint disable missing-type
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
                            menuAnchor.open();
                        }
                    }
                }
            }
        }
    }
}
