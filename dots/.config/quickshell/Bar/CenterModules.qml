import QtQuick
import QtQuick.Layouts

RowLayout {
    id: centerModulesRoot
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

    Pill {
        id: mediaPill
        innerPadding: 6
        pillSpacing: 12

        // left settings button
        MouseArea {
            id: leftTrigger
            implicitWidth: 28
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            BarText {
                anchors.centerIn: parent
                text: " ⚙"
                font.pixelSize: 20
                // color: themePalette.inactiveAccent
                Layout.alignment: Qt.AlignCenter
            }
            onClicked: console.log("Settings button clicked")
        }

        // center block: media player state details
        BarText {
            Layout.alignment: Qt.AlignCenter
            text: "󰎈 Currently Playing Track..."
            color: themePalette.statusVibrant
            font.pixelSize: 14
        }

        // right dnd button
        MouseArea {
            id: rightTrigger
            implicitWidth: 28
            Layout.fillHeight: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            BarText {
                anchors.centerIn: parent
                text: root.dndActive ? "󰂛" : "󰂚"
                font.pixelSize: 20
                color: root.dndActive ? themePalette.activeAccent : themePalette.textSub
                Layout.alignment: Qt.AlignCenter
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
