import QtQuick
import QtQuick.Layouts
import qs.modules.theme

Rectangle {
    id: root

    signal sliderMoved(real value)
    property alias value: sliderRoot.value
    property bool muted: false

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: Variables.dashInnerColSpacing
    Layout.rightMargin: Variables.dashInnerColSpacing
    Layout.bottomMargin: Variables.dashInnerColSpacing

    color: Colors.surface_variant
    radius: Variables.dashInnerRadius
    clip: true

    Text {
        id: percentText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Variables.dashInnerColSpacing + 2
        font.family: Variables.defaultFontFamily
        font.pixelSize: Variables.fontSmall
        color: Colors.textSub
        text: Math.round(root.value * 100) + "%"
    }

    Rectangle {
        id: sliderRoot

        property real value

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: Variables.spacingMedium * 2
        anchors.bottomMargin: Variables.spacingMedium
        implicitWidth: Variables.spacingLarge
        color: Colors.surface_container_low
        radius: width / 2

        // filled rect
        Rectangle {
            id: activeBar
            width: parent.width
            height: parent.height * sliderRoot.value
            anchors.bottom: parent.bottom       // fills from bottom
            radius: parent.radius
            color: root.muted ? Colors.error : Colors.primary
        }

        MouseArea {
            anchors.fill: parent

            // function to calculate and apply the value
            function updateValue(mouseY) {
                var val = 1.0 - (mouseY / height);
                var clamped = Math.max(0.0, Math.min(1.0, val));

                root.sliderMoved(clamped);
            }

            onPressed: (mouse) => {
                updateValue(mouse.y)
            }

            onPositionChanged: (mouse) => {
                updateValue(mouse.y)
            }
        }
    }
}
