//@ pragma IconTheme Papirus
import Quickshell
import QtQuick
import "Bar"
// import "scripts"

ShellRoot {
    id: root

    // global config properties
    property string activeBarLayout: "top-fragmented"  // OPTIONS: "vertical-sidebar", "minimal"
    property bool dndActive: false

    // shared state management objects:
    Colors { id: themePalette }
    //SystemStats { id: sysStats }

    // scrreen tracking window instantiation
    Variants {
	model: Quickshell.screens

        delegate: Component {
            Bar {
            // pass system model bounds down to individual monitgor frames
            targetScreen: modelData
            layoutStyle: root.activeBarLayout
            }
        }
    }
}
