import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: root

    required property var pamContext

    Layout.preferredHeight: Math.round(48 * Variables.scaleFactor)
    Layout.preferredWidth: Math.round(300 * Variables.scaleFactor)
    color: Colors.secondary_container
    radius: Variables.radiusLarge
    border.width: 1
    border.color: Colors.secondary

    function submitPassword() {
        if (passInput.text.length > 0) {
            root.pamContext.tryUnlock();
        }
    }

    Connections {
        target: root.pamContext
        function onAuthFailedChanged() {
            if (root.pamContext.authFailed) {
                passInput.clear();
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: Variables.iconMedium
            color: Colors.secondary
            text: Icons.lock
        }

        TextInput {
            id: passInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            font.family: Variables.sansFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: false
            echoMode: TextInput.Password
            inputMethodHints: Qt.ImhSensitiveData
            enabled: !root.pamContext.authenticating
            clip: true
            focus: true
            onTextChanged: root.pamContext.currentText = text
            onAccepted: root.submitPassword()

            StyledText {
                id: passPlaceholder
                anchors.centerIn: parent
                color: Colors.secondary_container
                text: "Enter your password"
                visible: passInput.text.length === 0
            }

            Row {
                id: passDotRow
                anchors.centerIn: parent
                spacing: Variables.spacingSmall
                visible: passInput.text.length > 0

                Repeater {
                    model: passInput.text.length
                    delegate: Rectangle {
                        id: dot
                        required property int index

                        implicitWidth: Math.round(8 * Variables.scaleFactor)
                        implicitHeight: implicitWidth
                        radius: width / 2
                        color: Colors.on_secondary_container

                        Component.onCompleted: dotAppearAnim.start()

                        ParallelAnimation {
                            id: dotAppearAnim
                            NumberAnimation {
                                target: dot
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: Variables.durationMedium
                                easing.type: Easing.Bezier
                                easing.bezierCurve: Variables.entranceCurve
                            }
                            NumberAnimation {
                                target: dot
                                property: "scale"
                                from: 0.2
                                to: 1
                                duration: Variables.durationFast
                                easing.type: Easing.Bezier
                                easing.bezierCurve: Variables.entranceCurve
                            }
                        }
                    }
                }
            }
        }

        // enter/confirm button
        BaseButton {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            inactiveColor: Colors.secondary
            activeColor: Colors.primary
            textColor: Colors.on_secondary
            textActiveColor: Colors.on_primary
            iconSize: Variables.iconMedium
            icon: Icons.arrowRight
            onClicked: root.submitPassword()
        }
    }
}
