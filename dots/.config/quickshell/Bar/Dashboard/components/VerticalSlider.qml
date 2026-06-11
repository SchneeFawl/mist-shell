import QtQuick
import QtQuick.Layouts

// qmllint disable unqualified

// slider container
Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: 5
    Layout.rightMargin: 5
    Layout.bottomMargin: 5

    color: themePalette.inactiveAccent
    radius: 9
    clip: true

    Rectangle {
        id: sliderRoot

        property real value: 0.5
        signal sliderMoved(real val)

        anchors.centerIn: parent
        implicitHeight: 200
        implicitWidth: 16
        color: themePalette.pillBackground
        radius: width / 2

        // filled rect
        Rectangle {
            id: activeBar
            width: parent.width
            height: parent.height * sliderRoot.value
            anchors.bottom: parent.bottom       // fills from bottom
            radius: parent.radius
            color: themePalette.activeAccent
        }

        MouseArea {
            anchors.fill: parent

            // function to calculate and apply the value
            function updateValue(mouseY) {
                var val = 1.0 - (mouseY / height);
                var clamped = Math.max(0.0, Math.min(1.0, val));

                sliderRoot.value = clamped;
                sliderRoot.sliderMoved(clamped);
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
