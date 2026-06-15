import QtQuick
import QtQuick.Layouts
// import qs.services
import qs.modules.theme

Rectangle {
    id: mediaContBtn

    property string icon
    property int iconSize: 32
    property int btnSize: 50

    signal clicked()

    Layout.preferredHeight: btnSize
    Layout.preferredWidth: btnSize
    color: Colors.textVibrant
    radius: 16

    Text {
        anchors.centerIn: parent
        text: mediaContBtn.icon
        font.pixelSize: mediaContBtn.iconSize
        color: Colors.inactiveAccent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mediaContBtn.clicked()
    }
}
