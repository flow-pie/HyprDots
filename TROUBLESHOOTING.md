# Troubleshooting Guide

Common issues and solutions for this Hyprland dotfiles configuration.

## Table of Contents
- [Installation Issues](#installation-issues)
- [Hyprland Issues](#hyprland-issues)
- [Display Issues](#display-issues)
- [Waybar Issues](#waybar-issues)
- [Keybinding Issues](#keybinding-issues)
- [Theme Issues](#theme-issues)
- [Performance Issues](#performance-issues)

---

## Installation Issues

### "Permission denied" during installation

**Cause**: Install script lacks execute permissions.

**Solution**:
```bash
chmod +x install.sh
./install.sh
```

### "Command not found: hyde-shell"

**Cause**: HyDE is not installed, but configuration references it.

**Solution**: See [HYDE.md](HYDE.md) for options:
1. Install HyDE (recommended for full features)
2. Remove HyDE-specific configurations (for standalone use)

### Existing configs are not backed up

**Cause**: The simple `install.sh` may overwrite without backup.

**Solution**: Use the `Builder` script instead:
```bash
chmod +x Builder
./Builder
```

Backups will be in `~/.config/backup-YYYYMMDD-HHMMSS/`

---

## Hyprland Issues

### Hyprland won't start

**Check logs**:
```bash
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log
```

**Common causes**:
1. **Invalid configuration syntax**
   ```bash
   # Test config without starting
   hyprland --check-config
   ```

2. **Missing dependencies**
   ```bash
   # Check if required packages are installed
   pacman -Q hyprland waybar kitty
   ```

3. **Monitor configuration error**
   - Edit `~/.config/hypr/monitors.conf`
   - Ensure monitor names match: `hyprctl monitors`

### "source: no such file or directory"

**Cause**: Configuration tries to source missing files.

**Solution**:
```bash
# Check which file is missing in the error
# Common culprits:
touch ~/.config/hypr/monitors.conf
touch ~/.config/hypr/workspaces.conf

# Or comment out the source line in hyprland.conf
```

### Keybindings don't work

**Check if Super key is bound to system**:
```bash
# Test if Hyprland receives Super key
hyprctl dispatch exec kitty
# If kitty opens, Hyprland is receiving keys
```

**Solution**: Ensure no other program is capturing the Super key (e.g., desktop environment settings).

---

## Display Issues

### Black screen on startup

**Possible causes**:

1. **Monitor configuration error**
   ```bash
   # Use emergency config
   echo "monitor=,preferred,auto,1" > ~/.config/hypr/monitors.conf
   ```

2. **Graphics driver issue**
   ```bash
   # Check if rendering backend works
   LIBVA_DRIVER_NAME=i965 hyprland  # For Intel
   # Or try software rendering
   WLR_RENDERER=pixman hyprland
   ```

### Wrong resolution or refresh rate

**Solution**:
```bash
# List available modes
hyprctl monitors

# Edit monitors.conf with correct values
# Example:
# monitor=HDMI-A-1,1920x1080@144,0x0,1
```

### Monitor not detected

**Check connection**:
```bash
# List all outputs
hyprctl monitors all

# If monitor appears as "Unknown", try:
monitor=HDMI-A-1,preferred,auto,1
```

**Force detection**:
```bash
# Restart display
hyprctl dispatch dpms off
sleep 1
hyprctl dispatch dpms on
```

### Scaling issues (text too small/large)

**Solution**: Edit `~/.config/hypr/monitors.conf`
```conf
# For HiDPI (4K) displays
monitor=,3840x2160@60,auto,2

# For mixed DPI setup
monitor=DP-1,3840x2160@60,0x0,2       # 4K scaled to 2x
monitor=HDMI-A-1,1920x1080@60,1920x0,1  # 1080p no scaling
```

---

## Waybar Issues

### Waybar not showing

**Check if Waybar is running**:
```bash
pgrep waybar
# If not running:
waybar &
```

**Check logs**:
```bash
waybar -l debug
```

### Waybar shows errors about missing modules

**Cause**: Configuration references HyDE-specific modules.

**Solution**: Edit `~/.config/waybar/config.jsonc` and remove:
```jsonc
// Remove or comment out:
"custom/hyde-menu",
"custom/wallchange",
"custom/theme",
"custom/wbar",
```

### Waybar fonts look wrong

**Check if font is installed**:
```bash
fc-list | grep -i "JetBrains"
```

**Install if missing**:
```bash
# Arch
sudo pacman -S ttf-jetbrains-mono-nerd

# Debian/Ubuntu
sudo apt install fonts-jetbrains-mono
```

### Waybar colors don't match theme

**Cause**: Wallbash colors not generated.

**Solution**:
```bash
# Edit ~/.config/waybar/theme.css manually
# Or use static colors
@define-color bar-bg rgba(0, 0, 0, 0.8);
@define-color main-fg #FFFFFF;
```

---

## Keybinding Issues

### Super + Q doesn't close windows

**Check keybinding**:
```bash
# Test with hyprctl
hyprctl dispatch killactive
```

**Verify configuration**:
```bash
grep "Super.*Q" ~/.config/hypr/keybindings.conf
```

### Media keys don't work

**Install playerctl**:
```bash
sudo pacman -S playerctl  # Arch
sudo apt install playerctl  # Debian/Ubuntu
```

**Test**:
```bash
playerctl play-pause
```

### Custom keybindings not working

**Check for conflicts**:
```bash
# List all bindings
hyprctl binds
```

**Reload configuration**:
```bash
# Super + Shift + R (default)
# Or:
hyprctl reload
```

---

## Theme Issues

### Colors look wrong

**Cause**: Wallbash not installed or colors not generated.

**Solution 1 - Use static theme**:
```bash
# Edit ~/.config/hypr/themes/user-theme.conf
# Use the hardcoded colors instead of wallbash variables
```

**Solution 2 - Install wallbash** (requires HyDE):
See [HYDE.md](HYDE.md)

### Transparency not working

**Check if opacity is set**:
```bash
# Test with a window
hyprctl setprop address:$(hyprctl activewindow -j | jq -r .address) alpha 0.8
```

**Enable blur**:
Edit `~/.config/hypr/themes/user-theme.conf`:
```conf
decoration {
    blur {
        enabled = yes
        size = 8
        passes = 3
    }
}
```

### Hyprlock doesn't show wallpaper

**Check wallpaper path**:
```bash
# Edit ~/.config/hypr/hyprlock.conf
# Set static wallpaper:
$BACKGROUND_PATH = /path/to/your/wallpaper.jpg
```

---

## Performance Issues

### High CPU usage

**Check processes**:
```bash
top
# Look for waybar, hyprpaper, or animation-heavy processes
```

**Solutions**:

1. **Reduce animations**:
   ```bash
   # Edit ~/.config/hypr/animations.conf
   # Use minimal preset or disable:
   animations {
       enabled = false
   }
   ```

2. **Disable blur**:
   ```bash
   # Edit theme config
   blur {
       enabled = no
   }
   ```

3. **Use powersaver workflow**:
   ```bash
   # Edit ~/.config/hypr/workflows.conf
   source = ./workflows/powersaver.conf
   ```

### High memory usage

**Check Waybar modules**:
```bash
# Disable heavy modules in ~/.config/waybar/config.jsonc
# Remove: custom/weather, custom/mediaplayer, etc.
```

**Reduce blur passes**:
```conf
blur {
    passes = 1  # Instead of 3
}
```

### Screen tearing

**Enable VRR (Variable Refresh Rate)**:
```conf
# In ~/.config/hypr/userprefs.conf
misc {
    vrr = 1
}
```

**Or force vsync**:
```conf
misc {
    no_vfr = true
}
```

---

## General Debugging

### Get Hyprland info
```bash
hyprctl version
hyprctl systeminfo
```

### Check configuration
```bash
# Validate without applying
hyprctl --check-config

# See active config
hyprctl getoption general
```

### Enable debug logs
```bash
# Start Hyprland with debug logging
HYPRLAND_LOG_WLR=1 hyprland
```

### Reset to defaults
```bash
# Backup your config
cp -r ~/.config/hypr ~/.config/hypr.backup

# Remove problematic configs
rm ~/.config/hypr/hyprland.conf

# Reinstall
cd ~/arch-dotfiles
./install.sh
```

---

## Getting Help

If issues persist:

1. **Check Hyprland Wiki**: https://wiki.hyprland.org
2. **Search Issues**: https://github.com/yourusername/arch-dotfiles/issues
3. **Hyprland Discord**: https://discord.gg/hyprland
4. **Post logs**: Include output of:
   ```bash
   hyprctl version
   hyprctl systeminfo
   cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log
   ```

---

## Quick Fixes Checklist

- [ ] Run `hyprctl reload` after config changes
- [ ] Check `hyprctl monitors` for display names
- [ ] Verify dependencies are installed
- [ ] Check log files for errors
- [ ] Test with minimal config
- [ ] Ensure proper file permissions
- [ ] Verify paths use $HOME not hardcoded paths
- [ ] Check for conflicting keybindings
- [ ] Disable HyDE-specific features if not installed
- [ ] Try performance workflows if slow
