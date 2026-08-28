import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

// qmllint disable unqualified

Rectangle {
    id: srPillRoot

    signal clicked()
    readonly property bool isHovered: mouseArea.containsMouse
    property bool editable: false
    property bool active: false
    property bool monoText: false
    property string staticText: "60s"
    property alias inputText: textInput.text
    property string valueText: ""
    property bool highlighted: false

    Layout.preferredHeight: parent.height
    Layout.fillWidth: true
    radius: Variables.dashInnerRadius
    color: "transparent"
    border.color: Colors.border
    border.width: editable ? 1 : 0

    TextInput {
        id: textInput
        anchors.centerIn: parent
        visible: srPillRoot.editable
        color: srPillRoot.highlighted ? Colors.on_primary : Colors.on_surface
        font.family: srPillRoot.monoText ? Variables.monoFontFamily : Variables.sansFontFamily
        font.pixelSize: Variables.fontNormal
        clip: true
        validator: IntValidator { bottom: 10; top: 3600 }
        text: srPillRoot.valueText
        cursorVisible: activeFocus

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Escape) {
                DashboardController.keyboardFocus = false;
                textInput.focus = false;
                event.accepted = true;
            }
        }

        onActiveFocusChanged:  {
            if (!activeFocus) {
                DashboardController.keyboardFocus = false;
            }
        }
    }

    ScreenRecordText {
        anchors.centerIn: parent
        visible: !srPillRoot.editable
        color: srPillRoot.highlighted ? Colors.on_primary : Colors.on_surface
        monospace: srPillRoot.monoText
        text: srPillRoot.staticText

        Behavior on color {
            ColorAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (srPillRoot.editable) {
                textInput.forceActiveFocus();
                DashboardController.keyboardFocus = true;
            } else {
                srPillRoot.clicked()
            }
        }
    }
}
