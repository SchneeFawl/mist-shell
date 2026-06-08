import QtQuick

// qmllint disable unqualified

Rectangle {
    property string icon: ""
    property int iconSize: 20
    property color btnBgColor: themePalette.pillBackground
    property bool active: false

    signal clicked()

    id: buttonRoot
    implicitWidth: 50
    implicitHeight: 50
    radius: 12
    color: active ? themePalette.activeBtnVibrant : btnBgColor

    Behavior on color {
        ColorAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    Text {
        text: buttonRoot.icon
        font.pixelSize: buttonRoot.iconSize
        color: "white"
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: buttonRoot.clicked()
    }
}
