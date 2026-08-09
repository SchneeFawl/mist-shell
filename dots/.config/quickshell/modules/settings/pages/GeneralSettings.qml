import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.theme
import qs.modules.common

Item {
    id: root
    anchors.fill: parent
    anchors.margins: Variables.spacingNormal

    ColumnLayout {
        id: titleRowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Variables.spacingMedium

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

        StyledSeparator {
            Layout.preferredHeight: Math.round(2 * Variables.scaleFactor)
            Layout.fillWidth: true
        }
    }

    Flickable {
        anchors.top: titleRowLayout.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Variables.spacingLarge

        boundsMovement: Flickable.StopAtBounds
        contentHeight: mainColumn.implicitHeight
        maximumFlickVelocity: 3000
        clip: true

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
        }
    }
}
