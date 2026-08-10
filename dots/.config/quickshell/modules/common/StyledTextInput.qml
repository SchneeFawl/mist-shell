import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: root

    property int baseHeight: Math.round(40 * Variables.scaleFactor)
    property int baseWidth: Variables.buttonHeight

    property string placeholderText: ""
    property color placeholderColor: Colors.surface_variant

    property var textChangeBehavior

    property string icon: ""
    property color iconColor: Colors.on_primary_container
    property int iconSize: Variables.iconNormal

    property color textInputColor: Colors.on_surface

    Layout.preferredWidth: baseWidth
    width: baseWidth
    Layout.preferredHeight: baseHeight
    height: baseHeight
    color: Colors.surface_container_high
    radius: Variables.radiusNormal
    clip: true

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: root.iconSize
            color: root.iconColor
            text: root.icon
        }

        TextInput {
            id: textInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillWidth: true
            color: root.textInputColor
            font.family: Variables.sansFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: true
            clip: true
            onTextChanged: root.textChangeBehavior
            enabled: root.visible
            focus: true
            selectionColor: Colors.primary

            StyledText {
                id: placeholder
                color: root.placeholderColor
                text: root.placeholderText
                visible: textInput.text.length === 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: textInput.forceActiveFocus();
    }
}
