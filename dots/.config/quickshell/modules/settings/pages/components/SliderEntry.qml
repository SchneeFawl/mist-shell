import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.theme

ColumnLayout {
    id: root

    property color entryTextColor: Colors.on_surface
    property color entryDescColor: Colors.secondary
    property string entryText: ""
    property string entryDesc: ""

    property real sliderValue
    property string sliderTextValue: ""
    property alias value: slider.value

    property color btnColor: "transparent"
    property int btnIconSize: Variables.iconLarge
    property string btnIcon: Icons.restoreDefault

    signal sliderValueCommitted(real finalValue)
    signal btnClicked()

    Layout.fillWidth: true
    spacing: Variables.spacingNormal

    ColumnLayout {
        id: masterLayout
        Layout.fillWidth: true
        spacing: Variables.spacingSmall

        // entry text
        StyledText {
            color: root.entryTextColor
            font.pixelSize: Variables.fontMedium
            text: root.entryText
        }

        // description
        StyledText {
            Layout.fillWidth: true
            font.pixelSize: Variables.fontSmall
            elide: Text.ElideRight
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            color: root.entryDescColor
            text: root.entryDesc
        }
    }

    RowLayout {
        id: sliderLayout
        Layout.fillWidth: true
        Layout.leftMargin: Variables.spacingSmall
        Layout.rightMargin: Variables.spacingSmall
        spacing: Variables.spacingLarge

        // text before slider (preferrably value percentage)
        StyledText {
            Layout.fillHeight: true
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: Variables.fontNormal
            text: root.sliderTextValue
        }

        StyledStepSlider {
            id: slider
            Layout.fillWidth: true
            Layout.preferredHeight: handleSize + Variables.spacingSmall
            value: root.sliderValue
            onValueCommitted: (finalValue) => root.sliderValueCommitted(finalValue)
        }

        // reset button
        BaseButton {
            Layout.preferredHeight: Variables.buttonHeightSmall
            Layout.preferredWidth: Variables.buttonHeightSmall
            color: root.btnColor
            iconSize: root.btnIconSize
            icon: root.btnIcon
            onClicked: root.btnClicked()
        }
    }
}
