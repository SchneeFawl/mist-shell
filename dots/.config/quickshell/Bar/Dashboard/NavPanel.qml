import QtQuick
import QtQuick.Layouts
import "components"

Rectangle {

    property int activeTab: 0
    signal tabSelected(int index)

    id: navWrapper
    anchors.fill: parent
    color: "transparent"
    radius: 12

    ColumnLayout {
        spacing: 2
        anchors.fill: parent

        NavButton {
            id: mediaModeBtn
            icon: "󰽴"
            iconSize: 20

            onClicked: {
                navWrapper.activeTab = 1;
                navWrapper.tabSelected(1);
                console.log("Clicked Tab 1")
            }

            active: navWrapper.activeTab === 1
        }

        NavButton {
            id: systemInfoBtn
            icon: ""
            iconSize: 24

            onClicked: {
                navWrapper.activeTab = 2;
                navWrapper.tabSelected(2);
                console.log("Clicked Tab 2")
            }

            active: navWrapper.activeTab === 2
        }

        NavButton {
            id: themeBtn
            icon: "󰏘"
            iconSize: 24

            onClicked: {
                navWrapper.activeTab = 3;
                navWrapper.tabSelected(3);
                console.log("Clicked Tab 3")
            }

            active: navWrapper.activeTab === 3
        }

        NavButton {
            id: appSelectBtn
            icon: "󰕮"
            iconSize: 22

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
            icon: "󰒓"
            iconSize: 24
            btnBgColor: "#2c3149"

            onClicked: {
                navWrapper.activeTab = 5;
                navWrapper.tabSelected(5);
                console.log("Clicked Tab 5")
            }

            active: navWrapper.activeTab === 5
        }
    }
}
