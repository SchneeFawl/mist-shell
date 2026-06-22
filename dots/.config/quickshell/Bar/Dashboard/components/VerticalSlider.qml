import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

// qmllint disable unqualified

// slider container
Rectangle {
    id: root

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: Variables.dashInnerColSpacing
    Layout.rightMargin: Variables.dashInnerColSpacing
    Layout.bottomMargin: Variables.dashInnerColSpacing

    color: Colors.surface_variant
    radius: Variables.dashInnerRadius
    clip: true

    signal sliderMoved(real value)
    property alias value: sliderRoot.value

    Rectangle {
        id: sliderRoot

        property real value

        anchors.centerIn: parent
        implicitHeight: 200
        implicitWidth: 16
        color: Colors.surface_container_low
        radius: width / 2

        // filled rect
        Rectangle {
            id: activeBar
            width: parent.width
            height: parent.height * sliderRoot.value
            anchors.bottom: parent.bottom       // fills from bottom
            radius: parent.radius
            color: Colors.primary
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
