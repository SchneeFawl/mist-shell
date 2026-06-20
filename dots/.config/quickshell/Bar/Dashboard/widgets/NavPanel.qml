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
        spacing: 2
        anchors.fill: parent

        NavButton {
            id: mediaModeBtn
            icon: Icons.navMusic
            iconSize: Variables.dashIconSize - 4

            onClicked: {
                navWrapper.activeTab = 1;
                navWrapper.tabSelected(1);
            }

            active: navWrapper.activeTab === 1
        }

        NavButton {
            id: systemInfoBtn
            icon: Icons.navSystemInfo
            iconSize: Variables.dashIconSize

            onClicked: {
                navWrapper.activeTab = 2;
                navWrapper.tabSelected(2);
                console.log("Clicked Tab 2")
            }

            active: navWrapper.activeTab === 2
        }

        NavButton {
            id: themeBtn
            icon: Icons.navTheme
            iconSize: Variables.dashIconSize

            onClicked: {
                navWrapper.activeTab = 3;
                navWrapper.tabSelected(3);
                console.log("Clicked Tab 3")
            }

            active: navWrapper.activeTab === 3
        }

        NavButton {
            id: appSelectBtn
            icon: Icons.navApps
            iconSize: Variables.dashIconSize - 2

            onClicked: {
                navWrapper.activeTab = 4;
                navWrapper.tabSelected(4);
                console.log("Clicked Tab 4")
            }

            active: navWrapper.activeTab === 4
        }

        Item { Layout.fillHeight: true }

        NavButton {
            id: settingsBtn
            icon: Icons.sysSettings
            iconSize: Variables.dashIconSize
            btnBgColor: Colors.surface_container_highest

            onClicked: {
                navWrapper.activeTab = 5;
                navWrapper.tabSelected(5);
                console.log("Clicked Tab 5")
            }

            active: navWrapper.activeTab === 5
        }
    }
}
