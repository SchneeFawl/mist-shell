//@ pragma UseQApplication
//@ pragma IconTheme Papirus
import Quickshell
import QtQuick
import "./Bar"
import qs.modules

// qmllint disable unqualified

ShellRoot {
    id: root

    // global config properties
    property string activeBarLayout: "top-fragmented"  // OPTIONS: "vertical-sidebar", "minimal"
    property bool dndActive: false

    // SystemStats { id: sysStats }

    Variants {
        model: Quickshell.screens

        delegate: NotificationsPopup {}
    }

    Variants {
	    model: Quickshell.screens

        delegate: Component {
            Bar {
                // pass system model bounds down to individual monitor
                layoutStyle: root.activeBarLayout
            }
        }
    }
}
