import QtQuick
import QtQuick.Layouts
// import qs.services
import qs.modules.theme

Rectangle {
    id: mediaContBtn

    property string icon
    property int iconSize: 36
    property color iconColor: Colors.inactiveAccent
    property int btnSize: 50

    property string btnOneIcon
    property string btnTwoIcon
    property string btnThreeIcon
    property real btnOneOpacity
    property real btnTwoOpacity
    property real btnThreeOpacity
    property real btnOneScale: 1.0
    property real btnTwoScale: 1.0
    property real btnThreeScale: 1.0

    signal clicked()

    Layout.preferredHeight: btnSize
    Layout.preferredWidth: btnSize
    color: Colors.textVibrant
    radius: 16

    Text {
        id: btnOne
        anchors.centerIn: parent
        text: mediaContBtn.btnOneIcon
        font.pixelSize: mediaContBtn.iconSize
        color: mediaContBtn.iconColor
        opacity: mediaContBtn.btnOneOpacity
        scale: mediaContBtn.btnOneScale

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
    }

    Text {
        id: btnTwo
        anchors.centerIn: parent
        text: mediaContBtn.btnTwoIcon
        font.pixelSize: mediaContBtn.iconSize
        color: mediaContBtn.iconColor
        opacity: mediaContBtn.btnTwoOpacity
        scale: mediaContBtn.btnTwoScale

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
    }

    Text {
        id: btnThree
        anchors.centerIn: parent
        text: mediaContBtn.btnThreeIcon
        font.pixelSize: mediaContBtn.iconSize
        color: mediaContBtn.iconColor
        opacity: mediaContBtn.btnThreeOpacity
        scale: mediaContBtn.btnThreeScale

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mediaContBtn.clicked()
    }
}
