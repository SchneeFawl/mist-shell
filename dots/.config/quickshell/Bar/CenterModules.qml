import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12

    Pill {
        id: mediaPill
        innerPadding: 12

        // left settings button
        MouseArea {
            id: leftTrigger
            Layout.preferredWidth: 20
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "⚙"
                color: parent.containsMouse ? themePalette.activeAccent : themePalette.inactiveAccent
            }
            onClicked: console.log("Settings button clicked")
        }

        // center block: media player state details
        BarText {
            Layout.alignment: Qt.AlignHCenter
            text: "󰎈 Currently Playing Track..."
            color: themePalette.statusVibrant
            font.pixelSize: 12
        }

        // right dnd button
        MouseArea {
            id: rightTrigger
            Layout.preferredWidth: 20
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: root.dndActive ? "󰂛" : "󰂚"
                color: root.dndActive ? themePalette.activeAccent : themePalette.textSub
            }
            onClicked: root.dndActive = !root.dndActive
        }

        // TODO: hovering scaling interaction mapping to Fabric widget layer
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            z: -1       // behind left/right trigger areas to avoid breaking button clicks
            onEntered: {
                mediaPill.border.color = themePalette.activeAccent
                // TODO: trigger event hook to load Fabric module
            }
            onExited: {
                mediaPill.border.color = themePalette.pillBorder
            }
        }
    }
}
