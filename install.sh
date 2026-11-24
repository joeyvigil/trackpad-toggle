#!/bin/bash
# Copy the plugin into the Omarchy shell's plugin directory and enable it.
# Re-run after editing to push changes (the shell hot-reloads on save).
set -euo pipefail
ID="io.github.joeyvigil.trackpad-toggle"
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.config/omarchy/plugins/$ID"

[[ -L $DEST ]] && rm "$DEST"
mkdir -p "$DEST/i18n"
cp "$SRC"/manifest.json "$SRC"/BarWidget.qml "$SRC"/README.md "$SRC"/LICENSE "$SRC"/preview.png "$DEST"/
cp "$SRC"/i18n/*.json "$DEST/i18n/"

omarchy-shell shell rescanPlugins >/dev/null 2>&1 || true
omarchy plugin enable "$ID" >/dev/null 2>&1 || true
echo "Installed $ID"
