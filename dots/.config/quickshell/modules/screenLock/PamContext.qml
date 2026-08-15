import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
    id: root

    property bool locked
    property bool authFailed
    property bool authenticating
    property string currentText: ""

    PamContext {
        id: pam
        configDirectory: "pam"
        config: "pam.conf"
        
        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }
        
        onCompleted: result => {
            if (result === PamResult.Success) {
                root.locked = false;
                root.authenticating = false;
                root.authFailed = false;
                root.currentText = "";
            } else {
                root.authFailed = true;
                root.authenticating = false;
                root.currentText = "";
            }
        }
    }

    function tryUnlock() {
        authenticating = true;
        authFailed = false;
        pam.start();
    }
}

