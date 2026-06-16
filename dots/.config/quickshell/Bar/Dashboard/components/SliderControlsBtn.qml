import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: sliderButtonRoot

    property int active
    signal clicked()

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: active ? Colors.activeBtnVibrant : Colors.inactiveAccent
    radius: Variables.dashInnerRadius

    Behavior on color {
        ColorAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    clip: true

    MouseArea {
        anchors.fill: parent
        onClicked: sliderButtonRoot.clicked()
    }
}
