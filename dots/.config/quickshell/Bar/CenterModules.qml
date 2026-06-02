import QtQuick

Pill {
    id: centerMediaPill

    property bool holdsTargetPointer: false

    Text {
        anchors.centerIn: parent
        text: "󰕮  System Center"
        color: "#cdd6f4"
        font.pixelSize: 14
    }
}

