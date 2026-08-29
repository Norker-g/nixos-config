import QtQuick

Item {
  id: root

  required property LockContext context
  required property real flakeProgress

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundColor
  }

  NixFlake {
    anchors.centerIn: parent
    progress: root.flakeProgress
  }

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundColor
    opacity: Theme.overlayOpacity * (1 - root.flakeProgress)
  }

  Column {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.verticalCenter
    anchors.topMargin: Theme.flakeFinalHeight / 2 + 38
    width: Theme.fieldWidth
    spacing: 12

    Rectangle {
      width: parent.width
      height: Theme.fieldHeight
      radius: Theme.fieldRadius
      color: Theme.fieldColor
      border.width: 1
      border.color: root.context.authenticationFailed ? Theme.errorColor : Theme.fieldBorderColor

    TextInput {
      id: passwordField
      anchors.fill: parent
      enabled: !root.context.authenticationInProgress && root.flakeProgress === 0
      text: root.context.currentText
      echoMode: TextInput.Password
      color: Theme.textColor
      font.family: Theme.fontFamily
      font.pixelSize: 16
      horizontalAlignment: TextInput.AlignHCenter
      verticalAlignment: TextInput.AlignVCenter
      selectByMouse: false
      focus: true

      onTextEdited: root.context.currentText = text
      onAccepted: root.context.tryUnlock()

      Component.onCompleted: forceActiveFocus()
    }
    }

    Text {
      width: parent.width
      height: 20
      horizontalAlignment: Text.AlignHCenter
      text: root.context.authenticationInProgress
        ? "Checking…"
        : root.context.authenticationFailed
          ? "Incorrect password"
          : "Enter password to unlock"
      color: root.context.authenticationFailed ? Theme.errorColor : Theme.mutedTextColor
      font.family: Theme.fontFamily
      font.pixelSize: 13
    }
  }
}
