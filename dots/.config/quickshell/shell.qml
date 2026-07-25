//@ pragma UseQApplication
//@ pragma IconTheme Papirus
import Quickshell
import QtQuick
import qs.modules
import "./bar"
import "./modules/screenCorners"

ShellRoot {
    id: shellRoot

    // global config properties
    property string activeBarLayout: "top-fragmented"  // OPTIONS: "vertical-sidebar", "minimal"

    ScreenCorners {}

    Variants {
        model: Quickshell.screens
        delegate: NotificationsPopup {}
    }

    Variants {
	    model: Quickshell.screens
        delegate: Component {
            Bar {
                layoutStyle: shellRoot.activeBarLayout      // qmllint disable unqualified
            }
        }
    }
}
