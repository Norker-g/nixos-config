import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
  id: root

  property real flakeProgress: 0
  property bool unlocking: false

  LockContext {
    id: lockContext

    onAuthenticationSucceeded: {
      if (!root.unlocking) {
        root.unlocking = true
        successAnimation.restart()
      }
    }
  }

  WlSessionLock {
    id: lock
    locked: true

    WlSessionLockSurface {
      color: Theme.backgroundColor

      LockSurface {
        anchors.fill: parent
        context: lockContext
        flakeProgress: root.flakeProgress
      }
    }
  }

  NumberAnimation {
    id: successAnimation
    target: root
    property: "flakeProgress"
    from: 0
    to: 1
    duration: Theme.unlockAnimationDuration
    easing.type: Easing.InOutCubic
    onFinished: {
      lock.locked = false
      Qt.quit()
    }
  }
}
