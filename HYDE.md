# HyDE Integration

This dotfiles configuration includes optional integration with **HyDE** (Hyprland Development Environment), a comprehensive theming and scripting framework for Hyprland.

## What is HyDE?

HyDE is a theme management system for Hyprland that provides:
- Dynamic color generation (wallbash)
- Theme switching utilities
- Pre-configured scripts for common tasks
- Waybar module management
- Hyprlock theme system

## Do I Need HyDE?

**No, HyDE is optional.** This dotfiles repository can work without HyDE, but some features will be unavailable:

### ✅ Works Without HyDE
- Basic Hyprland window management
- Kitty terminal configuration
- Vim configuration
- Waybar (with limited modules)
- All keybindings
- Window rules and animations

### ⚠️ Requires HyDE or Manual Setup
- `hyde-shell` commands in keybindings (can be replaced with direct commands)
- Wallbash color generation (can use static colors)
- Theme switching scripts
- Some Waybar modules (can be disabled)
- Hyprlock themes with dynamic colors

## Installing Without HyDE

If you want to use these dotfiles **without HyDE**, follow these steps:

### 1. Remove HyDE-Specific Keybindings

Edit `~/.config/hypr/keybindings.conf` and comment out or remove these bindings:

```conf
# Comment out these lines:
# bindd = $mainMod Alt, Right, next global wallpaper, exec, $scrPath/wallpaper.sh -Gn
# bindd = $mainMod Alt, Left, previous global wallpaper, exec, $scrPath/wallpaper.sh -Gp
# bindd = $mainMod Shift, W, select a global wallpaper, exec, pkill -x rofi || $scrPath/wallpaper.sh -SG
# bindd = $mainMod Alt, Up, next waybar layout, exec, $scrPath/wbarconfgen.sh n
# bindd = $mainMod Alt, Down, previous waybar layout, exec, $scrPath/wbarconfgen.sh p
# bindd = $mainMod Shift, R, wallbash mode selector, exec, pkill -x rofi || $scrPath/wallbashtoggle.sh -m
# bindd = $mainMod Shift, Y, select a theme, exec, pkill -x rofi || $scrPath/themeselect.sh
# bindd = $mainMod+Shift, Y, select animations, exec, pkill -x rofi || $scrPath/animations.sh --select
# bindd = $mainMod+Shift, U, select hyprlock layout, exec, pkill -x rofi || $scrPath/hyprlock.sh --select
```

### 2. Use Static Colors

Replace dynamic color references with static colors:

**In `~/.config/hypr/hyprland.conf`:**
```conf
# Remove or comment out:
# source = ~/.config/hypr/themes/user-theme.conf

# Instead, add your colors directly:
general {
    col.active_border = rgba(00ff88ff) rgba(00cc66ff) 45deg
    col.inactive_border = rgba(002211ff) rgba(001100ff) 45deg
}
```

### 3. Simplify Waybar

Edit `~/.config/waybar/config.jsonc` and remove modules that depend on HyDE scripts:

```jsonc
// Remove these modules:
"custom/hyde-menu",
"custom/wallchange",
"custom/theme",
"custom/wbar",
```

### 4. Remove Wallbash References

**In `~/.config/hypr/hyprland.conf`:**
```conf
# Remove:
# exec-once = hyprshade apply hacker-green
```

**In Waybar style files:**
Comment out wallbash imports if they cause errors.

## Installing WITH HyDE

If you want the full experience with all features:

### 1. Install HyDE

```bash
# Clone HyDE repository
git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE

# Run the installation script
cd ~/HyDE/Scripts
./install.sh
```

### 2. Install These Dotfiles

After HyDE is installed, these dotfiles will integrate seamlessly:

```bash
cd ~/arch-dotfiles
./install.sh
```

### 3. Verify Integration

Check that HyDE scripts are accessible:

```bash
which hyde-shell
which wallbash
```

## Replacing HyDE Scripts

If you want functionality without HyDE, here are alternatives:

### Wallpaper Management
Replace `$scrPath/wallpaper.sh` with:
```bash
# Using swww (recommended)
swww img ~/path/to/wallpaper.jpg

# Or using hyprpaper
hyprctl hyprpaper preload ~/path/to/wallpaper.jpg
hyprctl hyprpaper wallpaper "eDP-1,~/path/to/wallpaper.jpg"
```

### Screenshot
Replace `$scrPath/screenshot.sh` with:
```bash
# Full screenshot
grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png

# Area selection
grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
```

### Rofi Menus
Replace `$scrPath/rofilaunch.sh` with:
```bash
# Application launcher
rofi -show drun

# Window switcher
rofi -show window
```

### Volume Control
Replace `$scrPath/volumecontrol.sh` with:
```bash
# Increase volume
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Decrease volume
pactl set-sink-volume @DEFAULT_SINK@ -5%

# Mute toggle
pactl set-sink-mute @DEFAULT_SINK@ toggle
```

### Brightness Control
Replace `$scrPath/brightnesscontrol.sh` with:
```bash
# Increase brightness
brightnessctl set +10%

# Decrease brightness
brightnessctl set 10%-
```

## Minimal Dependencies

Without HyDE, you still need:

### Required
- Hyprland
- Waybar
- Kitty
- Rofi

### Recommended
- swww (wallpaper daemon)
- grim + slurp (screenshots)
- brightnessctl (brightness control)
- playerctl (media control)
- hyprpicker (color picker)

## Getting Help

If you encounter issues:

1. **With HyDE installed**: Check [HyDE documentation](https://github.com/prasanthrangan/hyprdots)
2. **Without HyDE**: See TROUBLESHOOTING.md for common issues
3. **General Hyprland**: Visit [Hyprland Wiki](https://wiki.hyprland.org)

## Summary

| Feature | Without HyDE | With HyDE |
|---------|-------------|-----------|
| Basic WM | ✅ Full | ✅ Full |
| Keybindings | ✅ Most work | ✅ All work |
| Themes | ⚠️ Manual | ✅ Automatic |
| Wallpapers | ⚠️ Manual | ✅ Automatic |
| Waybar | ⚠️ Limited | ✅ Full |
| Colors | ⚠️ Static | ✅ Dynamic |

**Recommendation**: Try without HyDE first. If you want more automation and theming features, install HyDE later.
