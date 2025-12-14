#!/bin/bash
set -e

# Script to fix dotfiles repository issues
# Run this in your dotfiles repository root

REPO_ROOT="$(pwd)"

echo "🔧 Fixing Arch Dotfiles Repository..."
echo "=================================="

# ============================================================================
# 1. Remove personal data (anaconda config from .zshrc)
# ============================================================================
echo ""
echo " Step 1: Removing personal data from .zshrc..."

cat > home/.zshrc << 'EOF'
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
EOF

git add home/.zshrc
git commit -m "Remove personal anaconda configuration from .zshrc"

echo "Personal data removed"

# ============================================================================
# 2. Fix hardcoded paths in configuration files
# ============================================================================
echo ""
echo "Step 2: Fixing hardcoded paths..."

# Fix hyprland.conf
sed -i 's|/home/jon|$HOME|g' home/.config/hypr/hyprland.conf
sed -i 's|source = /home/jon|source = $HOME|g' home/.config/hypr/hyprland.conf

# Fix hyprlock.conf
sed -i 's|/home/jon|$HOME|g' home/.config/hypr/hyprlock.conf
sed -i 's|$LAYOUT_PATH=/home/jon|$LAYOUT_PATH=$HOME|g' home/.config/hypr/hyprlock.conf

# Fix colors.conf
sed -i 's|source = /home/jon|source = $HOME|g' home/.config/hypr/colors.conf

# Fix shaders.conf
sed -i 's|/home/jon|$HOME|g' home/.config/hypr/shaders.conf

# Fix waybar includes
sed -i 's|/home/jon|$HOME|g' home/.config/waybar/includes/includes.json
sed -i 's|/home/jon|$HOME|g' home/.config/waybar/style.css

# Fix userprefs.conf - remove missing script reference
sed -i '/exec-once = ~\/.local\/bin\/hacker-focus-glow.sh/d' home/.config/hypr/userprefs.conf

git add home/.config/hypr/hyprland.conf \
        home/.config/hypr/hyprlock.conf \
        home/.config/hypr/colors.conf \
        home/.config/hypr/shaders.conf \
        home/.config/hypr/userprefs.conf \
        home/.config/waybar/includes/includes.json \
        home/.config/waybar/style.css

git commit -m "Replace hardcoded /home/jon paths with \$HOME variable"

echo "✅ Hardcoded paths fixed"

# ============================================================================
# 3. Add monitors.conf example
# ============================================================================
echo ""
echo "Step 3: Adding monitors.conf examples..."

cat > home/.config/hypr/monitors.conf << 'EOF'

# █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█ █▀
# █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄ ▄█

# Monitor Configuration
# See https://wiki.hyprland.org/Configuring/Monitors/

# ============================================================================
# Basic Configuration Examples
# ============================================================================

# Single monitor (auto-detect resolution and position)
# monitor=,preferred,auto,1

# Single 1920x1080 monitor at 60Hz
# monitor=,1920x1080@60,auto,1

# Single 2560x1440 monitor at 144Hz
# monitor=,2560x1440@144,auto,1

# Single 4K monitor at 60Hz with 1.5x scaling
# monitor=,3840x2160@60,auto,1.5

# ============================================================================
# Multi-Monitor Examples
# ============================================================================

# Dual monitor setup (laptop + external)
# Primary external on the left, laptop screen on the right
# monitor=HDMI-A-1,1920x1080@60,0x0,1
# monitor=eDP-1,1920x1080@60,1920x0,1

# Triple monitor setup
# monitor=DP-1,2560x1440@144,0x0,1
# monitor=DP-2,2560x1440@144,2560x0,1
# monitor=HDMI-A-1,1920x1080@60,5120x0,1

# Vertical monitor setup (center landscape, sides portrait)
# monitor=DP-1,1920x1080@60,0x0,1,transform,1
# monitor=DP-2,2560x1440@144,1080x0,1
# monitor=DP-3,1920x1080@60,3640x0,1,transform,3

# ============================================================================
# Laptop Configurations
# ============================================================================

# Laptop with lid closed (disable laptop screen)
# monitor=eDP-1,disable
# monitor=HDMI-A-1,preferred,auto,1

# Laptop docking station
# monitor=eDP-1,1920x1080@60,0x0,1
# monitor=DP-3,2560x1440@144,1920x0,1
# monitor=DP-4,2560x1440@144,4480x0,1

# ============================================================================
# High DPI / Scaling Examples
# ============================================================================

# 4K monitor with 2x scaling (looks like 1080p but sharper)
# monitor=,3840x2160@60,auto,2

# Mixed DPI setup (4K + 1080p)
# monitor=DP-1,3840x2160@60,0x0,2
# monitor=HDMI-A-1,1920x1080@60,1920x0,1

# ============================================================================
# Finding Your Monitor Names
# ============================================================================
# Run: hyprctl monitors
# This will show all connected monitors and their names (e.g., HDMI-A-1, DP-1, eDP-1)

# ============================================================================
# Monitor Syntax
# ============================================================================
# monitor=NAME,RESOLUTION@REFRESH,POSITION,SCALE,TRANSFORM,ROTATION
#
# NAME: Monitor name (e.g., HDMI-A-1, DP-1, eDP-1) or use , for auto-detect
# RESOLUTION: Width x Height (e.g., 1920x1080) or "preferred" for auto
# REFRESH: Refresh rate in Hz (e.g., @60, @144, @240)
# POSITION: X and Y coordinates (e.g., 0x0, 1920x0) or "auto"
# SCALE: Scaling factor (e.g., 1, 1.5, 2)
# TRANSFORM: Rotation (0=normal, 1=90°, 2=180°, 3=270°)
#
# Examples:
# monitor=HDMI-A-1,1920x1080@60,0x0,1
# monitor=eDP-1,preferred,auto,1.5
# monitor=DP-1,2560x1440@144,1920x0,1,transform,1

# ============================================================================
# Your Configuration
# ============================================================================
# Uncomment and modify the configuration that matches your setup

# Default: Auto-detect single monitor
monitor=,preferred,auto,1

# Disable unused monitors (if needed)
# monitor=HDMI-A-2,disable
EOF

git add home/.config/hypr/monitors.conf
git commit -m "Add comprehensive monitors.conf with examples and documentation"

echo "monitors.conf created with examples"

# ============================================================================
# 4. Document HyDE dependency
# ============================================================================
echo ""
echo "Step 4: Documenting HyDE dependency..."

cat > HYDE.md << 'EOF'
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

### Works Without HyDE
- Basic Hyprland window management
- Kitty terminal configuration
- Vim configuration
- Waybar (with limited modules)
- All keybindings
- Window rules and animations

### Requires HyDE or Manual Setup
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
| Basic WM |  Full |  Full |
| Keybindings |  Most work |  All work |
| Themes |  Manual |  Automatic |
| Wallpapers |  Manual |  Automatic |
| Waybar |  Limited |  Full |
| Colors |  Static |  Dynamic |

**Recommendation**: Try without HyDE first. If you want more automation and theming features, install HyDE later.
EOF

git add HYDE.md
git commit -m "docs: Add comprehensive HyDE documentation and alternatives"

echo " HyDE documentation created"

# ============================================================================
# 5. Create troubleshooting guide
# ============================================================================
echo ""
echo " Step 5: Creating troubleshooting guide..."

cat > TROUBLESHOOTING.md << 'EOF'
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
EOF

git add TROUBLESHOOTING.md
git commit -m "docs: Add comprehensive troubleshooting guide"

echo " Troubleshooting guide created"

# ============================================================================
# 6. Update main README with links to new docs
# ============================================================================
echo ""
echo " Step 6: Updating README with new documentation links..."

# Backup original README
cp README.md README.md.backup

# Create updated README with better documentation structure
cat > README.md << 'EOF'
# Arch Dotfiles

A curated collection of configuration files optimized for Linux with Hyprland window manager.

> **Note**: This configuration includes optional [HyDE](HYDE.md) integration for advanced theming, but works perfectly fine without it.

## Features

- **Hyprland** - Tiling window manager configuration with multiple workflows
- **Kitty** - GPU-based terminal emulator
- **Vim** - Text editor with dynamic color scheme
- **Waybar** - Wayland status bar for Hyprland
- **Multiple Themes** - Animation presets, color schemes, and workflows
- **Modular Design** - Easy to customize individual components

## Quick Start

### Prerequisites

**Minimum required packages:**
```bash
# Arch/Manjaro
sudo pacman -S hyprland hyprlock kitty waybar rofi

# Debian/Ubuntu
sudo apt install hyprland kitty waybar rofi

# Fedora
sudo dnf install hyprland kitty waybar rofi
```

**Recommended packages:**
```bash
# Additional utilities
sudo pacman -S swww grim slurp brightnessctl playerctl hyprpicker
```

**Optional**: For full theme and automation features, see [HyDE Integration](HYDE.md)

### Installation

#### Quick Install (5 minutes)

```bash
git clone https://github.com/yourusername/arch-dotfiles.git
cd arch-dotfiles
chmod +x install.sh
./install.sh
```

#### Advanced Install (Recommended)

```bash
git clone https://github.com/yourusername/arch-dotfiles.git
cd arch-dotfiles
chmod +x Builder
./Builder
```

The Builder script will:
-  Detect your distro automatically
-  Check for required dependencies
-  Create timestamped backups
-  Copy configs to your home directory
-  Generate detailed logs

### After Installation

1. **Configure your monitors** (required):
   ```bash
   vim ~/.config/hypr/monitors.conf
   # See file for examples, or use: monitor=,preferred,auto,1
   ```

2. **Reload Hyprland**: Press `Super + Shift + R`

3. **Test keybindings**: Press `Super + /` for keybinding hints

## Documentation

-  **[Installation Guide](INSTALLATION.md)** - Detailed setup instructions for all distros
-  **[Structure](STRUCTURE.md)** - Directory layout and file organization
-  **[HyDE Integration](HYDE.md)** - Optional theming framework (advanced features)
-  **[Troubleshooting](TROUBLESHOOTING.md)** - Solutions to common problems

## Distro Compatibility

###  Fully Supported
- **Arch Linux** - Full support (all scripts work perfectly)
- **Manjaro, EndeavourOS, ArcoLinux** - Full support
- **Debian/Ubuntu** - Config files work; install dependencies manually
- **Fedora** - Config files work; install dependencies manually
- **openSUSE** - Config files work; install dependencies manually

> **Note**: The configuration files are universal and work on any Linux distro with Hyprland. Installation scripts are optimized for Arch but work everywhere with manual dependency installation.

## Key Features

###  Workflows
Switch between optimized profiles:
- **Default** - Balanced performance and aesthetics
- **Gaming** - Maximum performance, minimal effects
- **Editing** - Color-accurate, reduced blur
- **Snappy** - Fast and responsive
- **Powersaver** - Battery-friendly

*Change in* `~/.config/hypr/workflows.conf`

###  Animations
Choose from 15+ animation presets:
- Minimal, Dynamic, High, Fast, and more
- Easy switching with animation selector

*Change in* `~/.config/hypr/animations.conf`

###  Hyprlock Themes
Multiple lock screen layouts:
- HyDE default, Anurati, SF Pro, IBM Plex, Greetd, and more

*Change in* `~/.config/hypr/hyprlock.conf`

###  Keybindings
Comprehensive and organized keybindings:
- Window management (Super + Arrow keys)
- Workspace navigation (Super + 1-0)
- App launcher (Super + A)
- Quick actions (screenshots, brightness, volume)

*View all:* Press `Super + /` or see `~/.config/hypr/keybindings.conf`

## Directory Structure

```
arch-dotfiles/
├── home/
│   ├── .config/
│   │   ├── hypr/          # Hyprland configuration
│   │   ├── kitty/         # Terminal config
│   │   ├── vim/           # Vim config
│   │   └── waybar/        # Status bar config
│   └── .zshrc             # Shell configuration
├── install.sh             # Simple installer
├── Builder                # Advanced installer
├── README.md              # This file
├── INSTALLATION.md        # Detailed install guide
├── STRUCTURE.md           # File organization
├── HYDE.md                # HyDE integration info
├── TROUBLESHOOTING.md     # Problem solutions
└── LICENSE                # MIT License
```

## Customization

### Quick Customizations

**Change colors:**
```bash
vim ~/.config/hypr/themes/user-theme.conf
```

**Modify keybindings:**
```bash
vim ~/.config/hypr/keybindings.conf
```

**Switch workflows:**
```bash
vim ~/.config/hypr/workflows.conf
# Change the source line to your preferred workflow
```

**Configure monitors:**
```bash
vim ~/.config/hypr/monitors.conf
# See file for many examples
```

## Usage Without HyDE

This configuration is designed to work standalone **without HyDE**. You'll get:

 Full Hyprland window management  
 All keybindings and shortcuts  
 Static themes and colors  
 Waybar status bar  
 Multiple workflows and animations  

Some features require manual setup without HyDE:
- Dynamic color generation (use static colors)
- Automatic theme switching (use manual config)
- Advanced wallpaper management (use swww directly)

**See [HYDE.md](HYDE.md) for detailed comparison and alternatives.**

## Troubleshooting

Having issues? Check our [Troubleshooting Guide](TROUBLESHOOTING.md) for:

- Installation problems
- Display configuration issues  
- Keybinding conflicts
- Performance optimization
- Theme and color problems

**Quick fixes:**
```bash
# Reload Hyprland config
hyprctl reload

# Check your monitors
hyprctl monitors

# View configuration status
hyprctl getoption general
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Screenshots

*Coming soon - add your screenshots here!*

## Credits

- Based on best practices from the Hyprland community
- Animation presets from various contributors
- HyDE integration compatibility
- Special thanks to all contributors

## License

MIT License - See [LICENSE](LICENSE) file for details

## Support

-  [Hyprland Wiki](https://wiki.hyprland.org)
-  [Hyprland Discord](https://discord.gg/hyprland)
-  [Report Issues](https://github.com/yourusername/arch-dotfiles/issues)

---

**Happy ricing!** 🎨
EOF

git add README.md
git commit -m "docs: Update README with improved structure and documentation links"

echo " README updated"

# ============================================================================
# 7. Add a helpful script detection helper
# ============================================================================
echo ""
echo " Step 7: Creating script availability checker..."

cat > check-dependencies.sh << 'EOF'
#!/bin/bash

# Check which optional dependencies and scripts are available

echo " Checking Hyprland Dotfiles Dependencies"
echo "==========================================="
echo ""

# Required dependencies
echo " Required Packages:"
required=("hyprland" "waybar" "kitty" "rofi")
for pkg in "${required[@]}"; do
    if command -v "$pkg" &> /dev/null; then
        echo "   $pkg"
    else
        echo "   $pkg (REQUIRED - please install)"
    fi
done

echo ""
echo " Recommended Packages:"
recommended=("swww" "grim" "slurp" "brightnessctl" "playerctl" "hyprpicker")
for pkg in "${recommended[@]}"; do
    if command -v "$pkg" &> /dev/null; then
        echo "   $pkg"
    else
        echo "    $pkg (recommended)"
    fi
done

echo ""
echo " HyDE Integration:"
if command -v hyde-shell &> /dev/null; then
    echo "   HyDE is installed"
    echo "    All features available"
else
    echo "    HyDE not found"
    echo "    Basic features work, advanced theming unavailable"
    echo "   See HYDE.md for installation or alternatives"
fi

echo ""
echo " Fonts:"
if fc-list | grep -qi "jetbrains"; then
    echo "   JetBrains Mono Nerd Font"
else
    echo "    JetBrains Mono Nerd Font (install for proper icons)"
fi

echo ""
echo "==========================================="
echo "Legend:"
echo "   = Installed and available"
echo "   = Missing (required)"
echo "    = Missing (optional)"
echo ""
echo "For installation help, see INSTALLATION.md"
EOF

chmod +x check-dependencies.sh

git add check-dependencies.sh
git commit -m "feat: Add dependency checker script"

echo " Dependency checker created"

# ============================================================================
# Done!
# ============================================================================
echo ""
echo " All fixes completed!"
echo ""
echo "Summary of changes:"
echo "  1.  Removed personal data from .zshrc"
echo "  2.  Fixed hardcoded /home/jon paths"
echo "  3.  Added monitors.conf with examples"
echo "  4.  Created HYDE.md documentation"
echo "  5.  Created TROUBLESHOOTING.md guide"
echo "  6.  Updated README.md with new structure"
echo "  7.  Added dependency checker script"
echo ""
echo " Git Status:"
git log --oneline -7
echo ""
echo " Ready to push! Run:"
echo "   git push origin main"
echo ""
echo " To test the fixes:"
echo "   ./check-dependencies.sh"