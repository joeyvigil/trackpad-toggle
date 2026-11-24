// Trackpad Toggle bar widget.
//
// Click to turn the trackpad off or on. The work is done by Omarchy's own
// `omarchy toggle touchpad`, so the OSD, the Hyprland device rule, and the
// state that survives a reload all behave exactly like the built-in toggle.
//
// That command records "disabled" by writing the device name to a state file
// and deletes the file on enable, so the widget reads the file to know the
// state. It stays correct when the toggle runs from a keybinding or terminal.

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "io.github.joeyvigil.trackpad-toggle"

  // Same hardcoded path omarchy-toggle-input-device uses.
  readonly property string stateFile: Quickshell.env("HOME") + "/.local/state/omarchy/toggles/hypr/touchpad-disabled-name"

  property bool disabled: false
  property bool hasDevice: true

  Translations { id: strings; directory: Qt.resolvedUrl("i18n") }

  function refresh() {
    stateView.reload()
  }

  function toggle() {
    toggleProc.running = true
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  FileView {
    id: stateView
    path: root.stateFile
    watchChanges: true
    printErrors: false
    onFileChanged: reload()
    onLoaded: root.disabled = true
    onLoadFailed: root.disabled = false
  }

  // A missing file (or directory) can't be watched, so check gently in case
  // the toggle is flipped from somewhere else.
  Timer {
    interval: 3000
    repeat: true
    running: true
    onTriggered: root.refresh()
  }

  Process {
    id: toggleProc
    command: ["omarchy-toggle-touchpad", "toggle"]
    onExited: function(code) {
      root.hasDevice = code === 0
      root.refresh()
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    // nf-md-trackpad when on, nf-md-trackpad_lock when off.
    text: root.disabled ? "\u{F0933}" : "\u{F07F8}"
    slotSize: Style.bar.statusSlot
    active: root.disabled
    dimmed: !root.hasDevice
    tooltipText: !root.hasDevice ? strings.t("tooltip.missing")
               : root.disabled ? strings.t("tooltip.disabled")
               : strings.t("tooltip.enabled")

    onPressed: function(b) {
      if (b === Qt.LeftButton) root.toggle()
    }
  }
}
