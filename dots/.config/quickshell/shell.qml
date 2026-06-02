//@ pragma IconTheme Papirus
//@ pragma UseQApplication
import Quickshell
import QtQuick
import "Bar"
import "scripts"

ShellRoot {
    id: root

    // global config properties
    property string activeBarLayout: "top-fragmented"  // OPTIONS: "vertical-sidebar", "minimal"
    property bool dndActive: false

    Colors { id: themePalette }
    Variables { id: variables }
    SystemStats { id: sysStats }

    // scrreen tracking window instantiation
    Variants {
	model: Quickshell.screens

        delegate: Component {
            Bar {
                // pass system model bounds down to individual monitgor frames
                layoutStyle: root.activeBarLayout
            }
        }
    }
}
