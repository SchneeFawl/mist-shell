//@ pragma UseQApplication
//@ pragma IconTheme Papirus
import Quickshell
import QtQuick
import "./shell"

ShellRoot {
    id: shellRoot

    Variants {
        model: Quickshell.screens
        delegate: Component {
            ScreenModules {
            }
        }
    }
}
