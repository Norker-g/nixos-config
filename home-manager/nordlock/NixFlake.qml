import QtQuick

Item {
  id: root

  property real progress: 0

  implicitWidth: Theme.flakeFinalWidth
  implicitHeight: Theme.flakeFinalHeight
  scale: Theme.flakeRestScale
    + (Theme.flakeFinalScale - Theme.flakeRestScale) * progress
  rotation: Theme.flakeUnlockRotation * (1 - progress)

  Image {
    anchors.fill: parent
    source: Theme.wallpaper
    sourceClipRect: Theme.flakeSourceRect
    fillMode: Image.Stretch
    smooth: true
  }
}
