# Trackpad Toggle

An Omarchy shell bar widget that turns the laptop trackpad on and off.

- **Click** the trackpad icon to disable or enable the trackpad.
- The icon switches to a locked trackpad and highlights while the trackpad is off.
- It wraps Omarchy's built-in `omarchy toggle touchpad`, so you get the normal
  OSD, and the disabled state survives Hyprland reloads and reboots.
- The icon stays in sync when the toggle runs from a keybinding or a terminal.

## Install

```bash
omarchy plugin add https://github.com/joeyvigil/trackpad-toggle --enable
```

Or from a local checkout:

```bash
./install.sh
```

## Optional keybinding

Add this to `~/.config/hypr/bindings.lua` to toggle from the keyboard too:

```lua
o.bind("SUPER CTRL, T", "Toggle trackpad", "omarchy toggle touchpad")
```

## License

MIT
