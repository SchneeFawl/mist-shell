//@ pragma UseQApplication
import Quickshell
import QtQuick
import "./Bar"
import qs.scripts
import qs.modules
// import qs.services

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

    // screen tracking window instantiation
    Variants {
	    model: Quickshell.screens

        delegate: Component {
            Bar {
                // pass system model bounds down to individual monitor frames
                layoutStyle: root.activeBarLayout
            }
        }
    }
}
