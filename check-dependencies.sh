#!/bin/bash

# Check which optional dependencies and scripts are available

echo "🔍 Checking Hyprland Dotfiles Dependencies"
echo "==========================================="
echo ""

# Required dependencies
echo "📦 Required Packages:"
required=("hyprland" "waybar" "kitty" "rofi")
for pkg in "${required[@]}"; do
    if command -v "$pkg" &> /dev/null; then
        echo "  ✅ $pkg"
    else
        echo "  ❌ $pkg (REQUIRED - please install)"
    fi
done

echo ""
echo "📦 Recommended Packages:"
recommended=("swww" "grim" "slurp" "brightnessctl" "playerctl" "hyprpicker")
for pkg in "${recommended[@]}"; do
    if command -v "$pkg" &> /dev/null; then
        echo "  ✅ $pkg"
    else
        echo "  ⚠️  $pkg (recommended)"
    fi
done

echo ""
echo "🎨 HyDE Integration:"
if command -v hyde-shell &> /dev/null; then
    echo "  ✅ HyDE is installed"
    echo "  ℹ️  All features available"
else
    echo "  ⚠️  HyDE not found"
    echo "  ℹ️  Basic features work, advanced theming unavailable"
    echo "  📖 See HYDE.md for installation or alternatives"
fi

echo ""
echo "🔤 Fonts:"
if fc-list | grep -qi "jetbrains"; then
    echo "  ✅ JetBrains Mono Nerd Font"
else
    echo "  ⚠️  JetBrains Mono Nerd Font (install for proper icons)"
fi

echo ""
echo "==========================================="
echo "Legend:"
echo "  ✅ = Installed and available"
echo "  ❌ = Missing (required)"
echo "  ⚠️  = Missing (optional)"
echo ""
echo "For installation help, see INSTALLATION.md"
