import QtQuick
import QtQuick.Layouts

Rectangle {
    property real value: 0.5
    signal sliderMoved(real val)

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: 5
    Layout.rightMargin: 5
    Layout.bottomMargin: 5

    color: themePalette.inactiveAccent
    radius: 9
}
