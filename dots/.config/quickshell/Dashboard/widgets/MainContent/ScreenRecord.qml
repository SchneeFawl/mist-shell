import QtQuick
import QtQuick.Controls
import "./ScreenRecord"
import qs.modules.theme

Rectangle {
    id: recordRoot

    property bool showSettings: false

    anchors.fill: parent
    color: Colors.surface_container_low
    radius: Variables.dashColumnRadius
    clip: true

    StackView {
        id: recordStack
        anchors.fill: parent
        initialItem: ScreenRecordMain {}
    }
}
