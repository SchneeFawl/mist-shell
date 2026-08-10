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
            anchors.fill: parent
            spacing: Variables.spacingNormal

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: defaultFontColumn.height
                spacing: Variables.spacingNormal

                Column {
                    id: defaultFontColumn
                    spacing: Variables.spacingSmall

                    StyledText {
                        font.pixelSize: Variables.fontMedium
                        text: "Default font"
                    }
                    StyledText {
                        font.pixelSize: Variables.fontSmall
                        text: "Font used for the general interface"
                    }
                }

                Item { Layout.fillWidth: true }

                StyledTextInput {
                    id: defaultFontInput
                    baseWidth: Math.round(240 * Variables.scaleFactor)
                    baseHeight: defaultFontColumn.height - Variables.spacingSmall
                    icon: Icons.textShadow
                    placeholderText: Variables.sansFontFamily
                }

                BaseButton {
                    Layout.preferredHeight: defaultFontColumn.height - Variables.spacingSmall
                    Layout.preferredWidth: height
                    icon: Icons.checkMark
                    onClicked: SettingsService.general.sansFontFamily = defaultFontInput.textInputText
                }
            }
        }
    }
}
