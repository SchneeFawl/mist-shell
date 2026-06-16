import QtQuick
import QtQuick.Layouts
// import qs.services
import qs.modules.theme

Rectangle {
    id: mediaContBtn

    property string icon
    property int iconSize: 36
    property color iconColor: "transparent"
    property int btnSize: 50

    signal clicked()

    // private properties to manage animation
    property bool showSecondIcon: false
    property bool _initialized: false

    onIconChanged: {
        if (!_initialized) return;

        if (showSecondIcon) {
            text1.text = icon
            showSecondIcon = false;
        } else {
            text2.text = icon;
            showSecondIcon = true;
        }
    }

    Component.onCompleted: {
        text1.text = icon;
        _initialized = true;
    }

    Layout.preferredHeight: btnSize
    Layout.preferredWidth: btnSize
    color: Colors.textVibrant
    radius: 16

    Text {
        id: text1
        anchors.centerIn: parent
        text: mediaContBtn.icon
        font.pixelSize: mediaContBtn.iconSize
        color: mediaContBtn.iconColor
        opacity: mediaContBtn.showSecondIcon ? 0.0 : 1.0
        scale: mediaContBtn.showSecondIcon ? 0.6 : 1.0

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
    }

    Text {
        id: text2
        anchors.centerIn: parent
        text: mediaContBtn.icon
        font.pixelSize: mediaContBtn.iconSize
        color: mediaContBtn.iconColor
        opacity: mediaContBtn.showSecondIcon ? 1.0 : 0.0
        scale: mediaContBtn.showSecondIcon ? 1.0 : 0.6

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mediaContBtn.clicked()
    }
}
