#!/bin/bash
set -e

# Arch Dotfiles Installer
# Installs dotfiles to home directory

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Create directories if they don't exist
mkdir -p "$HOME_DIR/.config"
mkdir -p "$HOME_DIR/.local/bin"

# Install configs
for file in "$DOTFILES_DIR/home"/{.config,.*}; do
    [ -e "$file" ] || continue
    filename=$(basename "$file")
    
    # Skip git-related files
    if [[ "$filename" == ".git"* ]]; then
        continue
    fi
    
    target="$HOME_DIR/$filename"
    
    if [ -e "$target" ]; then
        echo "  Backing up existing $filename..."
        mv "$target" "$target.bak.$(date +%s)"
    fi
    
    echo "  Installing $filename..."
    cp -r "$file" "$target"
done

echo "Installation complete!"
echo "Note: Some configs may need additional dependencies. Check README.md"
