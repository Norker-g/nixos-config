import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
  id: root

  signal authenticationSucceeded()

  property string currentText: ""
  property bool authenticationInProgress: false
  property bool authenticationFailed: false

  onCurrentTextChanged: {
    if (currentText.length > 0)
      authenticationFailed = false
  }

  function tryUnlock() {
    if (currentText.length === 0 || authenticationInProgress)
      return

    authenticationInProgress = true
    authenticationFailed = false
    pam.start()
  }

  PamContext {
    id: pam
    // This is declared as security.pam.services.quickshell-lock in NixOS.
    config: "quickshell-lock"

    onPamMessage: {
      if (responseRequired)
        respond(root.currentText)
    }

    onCompleted: result => {
      root.authenticationInProgress = false

      if (result === PamResult.Success) {
        root.currentText = ""
        root.authenticationSucceeded()
      } else {
        root.currentText = ""
        root.authenticationFailed = true
      }
    }
  }
}
