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
- Detect your distro automatically
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

**Happy ricing!** 
