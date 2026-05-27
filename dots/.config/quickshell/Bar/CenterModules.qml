import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

    Pill {
        id: mediaPill
        innerPadding: 14
        pillSpacing: 0

        // left settings button
        MouseArea {
            id: leftTrigger
            Layout.preferredWidth: 24
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor

            BarText {
                anchors.centerIn: parent
                text: "⚙"
                font.pixelSize: 20
                color: parent.containsMouse ? themePalette.activeAccent : themePalette.inactiveAccent
            }
            onClicked: console.log("Settings button clicked")
        }

        // center block: media player state details
        BarText {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "󰎈 Currently Playing Track..."
            color: themePalette.statusVibrant
            font.pixelSize: 14
        }

        // right dnd button
        MouseArea {
            id: rightTrigger
            Layout.preferredWidth: 24
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            BarText {
                anchors.centerIn: parent
                text: root.dndActive ? "󰂛" : "󰂚"
                font.pixelSize: 20
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
                mediaPill.customBorderColor = themePalette.activeAccent
                // TODO: trigger event hook to load Fabric module
            }
            onExited: {
                mediaPill.customBorderColor = themePalette.pillBorder
            }
        }
    }
}
