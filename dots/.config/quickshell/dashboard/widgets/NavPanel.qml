
import QtQuick
import QtQuick.Layouts
import "../components"
import qs.modules.theme

Rectangle {

    property int activeTab: 1
    signal tabSelected(int index)

    id: navWrapper
    anchors.fill: parent
    color: "transparent"

    ColumnLayout {
        spacing: Variables.dashInnerColSpacing
        anchors.fill: parent

        NavButton {
            id: mediaModeBtn
            icon: Icons.navMusic
            iconSize: Variables.iconNormal

            onClicked: {
                navWrapper.activeTab = 1;
                navWrapper.tabSelected(1);
            }

            active: navWrapper.activeTab === 1
        }

        NavButton {
            id: systemInfoBtn
            icon: Icons.navSystemInfo
            iconSize: Variables.iconNormal

            onClicked: {
                navWrapper.activeTab = 2;
                navWrapper.tabSelected(2);
            }

            active: navWrapper.activeTab === 2
        }

        NavButton {
            id: themeBtn
            icon: Icons.navTheme
            iconSize: Variables.iconNormal

            onClicked: {
                navWrapper.activeTab = 3;
                navWrapper.tabSelected(3);
            }

            active: navWrapper.activeTab === 3
        }

        NavButton {
            id: recordBtn
            icon: Icons.navRecord
            iconSize: Variables.iconNormal

            onClicked: {
                navWrapper.activeTab = 4;
                navWrapper.tabSelected(4);
            }

            active: navWrapper.activeTab === 4
        }

        Item { Layout.fillHeight: true }

        NavButton {
            id: settingsBtn
            icon: Icons.sysSettings
            iconSize: Variables.iconNormal
            btnBgColor: Colors.surface_container_highest

            onClicked: {
                navWrapper.activeTab = 5;
                navWrapper.tabSelected(5);
            }

            active: navWrapper.activeTab === 5
        }
    }
}
