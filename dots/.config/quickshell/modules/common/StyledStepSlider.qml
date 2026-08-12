import QtQuick
import qs.modules.theme

Item {
    id: root

    property real value: 1.0
    property real from: 0.0
    property real to: 2.0
    property real stepSize: 0.05

    signal valueMoved(real newValue)
    signal valueCommitted(real finalValue)

    property int handleSize: Math.round(24 * Variables.scaleFactor)
    property int trackHeight: Math.round(9* Variables.scaleFactor)
    property int gapSizing: Variables.spacingSmall

    readonly property real progressRatio: Math.max(0.0, Math.min(1.0, (value - from) / (to - from)))
    readonly property real handleX: Math.round(progressRatio * (root.width - handleSize))


    implicitWidth: Math.round(200 * Variables.scaleFactor)
    implicitHeight: handleSize

    Rectangle {
        id: filledTrack
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: Math.max(0, root.handleX - root.gapSizing)
        height: root.trackHeight
        radius: height / 2
        color: Colors.primary
    }

    Rectangle {
        id: thumbHandle
        anchors.verticalCenter: parent.verticalCenter
        x: root.handleX
        width: root.handleSize
        height: root.handleSize
        radius: root.handleSize / 2
        color: Colors.primary_container
        border.width: Math.round(2 * Variables.scaleFactor)
        border.color: Colors.primary
    }

    Rectangle {
        id: unfilledTrack
        anchors.verticalCenter: parent.verticalCenter
        x: root.handleX + root.handleSize + root.gapSizing
        width: Math.max(0, root.width - (root.handleX + root.handleSize + root.gapSizing))
        height: root.trackHeight
        radius: height / 2
        color: Colors.tertiary
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        function updatePos(mouse) {
            if (root.width <= root.handleSize) return;

            let rawRatio = (mouse.x - root.handleSize / 2) / (root.width - root.handleSize);
            let rawVal = root.from + rawRatio * (root.to - root.from);

            let steps = Math.round((rawVal - root.from) / root.stepSize);
            let steppedVal = Math.max(root.from, Math.min(root.to, root.from + steps * root.stepSize));

            // update only when value actually crossed a step
            if (Math.abs(steppedVal - root.value) > 0.0001) {
                root.value = steppedVal;
                root.valueMoved(steppedVal);
            }
        }

        onPressed: (mouse) => updatePos(mouse)
        onPositionChanged: (mouse) => updatePos(mouse)
        onReleased: root.valueCommitted(root.value)
    }
}

