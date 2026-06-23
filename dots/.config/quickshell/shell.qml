//@ pragma UseQApplication
//@ pragma IconTheme Papirus
import Quickshell
import QtQuick
import "./Bar"
import qs.modules

ShellRoot {
    id: shellRoot

    // global config properties
    property string activeBarLayout: "top-fragmented"  // OPTIONS: "vertical-sidebar", "minimal"

    Variants {
        model: Quickshell.screens

        delegate: NotificationsPopup {}
    }

    Variants {
	    model: Quickshell.screens

        delegate: Component {
            Bar {
                // pass system model bounds down to individual monitor
                layoutStyle: shellRoot.activeBarLayout      // qmllint disable unqualified
            }
        }
    }
}
