import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Flickable {
    id: root

    anchors.fill: parent
    anchors.margins: Variables.spacingNormal

    // boundsMovement: Flickable.StopAtBounds
    contentHeight: mainColumn.implicitHeight
    maximumFlickVelocity: 3000

    Behavior on contentY {
        NumberAnimation {
            duration: Variables.durationFast
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.entranceCurve
        }
    }

    ColumnLayout {
        id: mainColumn
        spacing: Variables.spacingNormal

        Row {
            spacing: Variables.spacingNormal

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.iconLargest
                color: Colors.primary
                text: Icons.sliders
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Variables.fontLargest
                color: Colors.primary
                text: "General"
            }
        }
    }
}
