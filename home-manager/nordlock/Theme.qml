pragma Singleton

import QtQuick

QtObject {
  // Change these named values to retheme nordlock without touching its layout.
  readonly property url wallpaper: "file:///home/norker/Pictures/wallpapers/NixOs.png"
  readonly property color backgroundColor: "#2E3440"
  readonly property color textColor: "#D8DEE9"
  readonly property color mutedTextColor: "#B8C0CC"
  readonly property color accentColor: "#88C0D0"
  readonly property color fieldColor: Qt.rgba(59 / 255, 66 / 255, 82 / 255, 0.86)
  readonly property color fieldBorderColor: Qt.rgba(136 / 255, 192 / 255, 208 / 255, 0.55)
  readonly property color errorColor: "#BF616A"

  readonly property string fontFamily: "Hack Nerd Font"
  // This crop contains the wallpaper's original Nix snowflake.
  readonly property rect flakeSourceRect: Qt.rect(660, 280, 600, 520)
  readonly property int flakeFinalWidth: 600
  readonly property int flakeFinalHeight: 520
  readonly property real flakeRestScale: 0.36
  readonly property real flakeFinalScale: 0.80
  readonly property real flakeUnlockRotation: 180
  readonly property int unlockAnimationDuration: 800
  readonly property real overlayOpacity: 0.18
  readonly property int fieldWidth: 300
  readonly property int fieldHeight: 48
  readonly property int fieldRadius: 14
}
