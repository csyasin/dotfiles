#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Function to create symbolic link with optional backup
create_link() {
    local source="$1"
    local target="$2"
    local backup="${3:-false}"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "✓ $target is already linked correctly"
        return
    fi

    if [ -e "$target" ] && [ "$backup" = true ]; then
        echo "Backing up $target to ${target}.bak"
        mv "$target" "${target}.bak"
    elif [ -e "$target" ]; then
        echo "Removing existing $target"
        rm -rf "$target"
    fi

    echo "Creating link: $target -> $source"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
}

echo "Setting up dotfiles..."

# zsh
create_link "$DOTFILES_DIR/.zshrc" ~/.zshrc true

# starship
create_link "$DOTFILES_DIR/starship" ~/.config/starship

# ghostty
create_link "$DOTFILES_DIR/ghostty" ~/.config/ghostty

# warp
create_link "$DOTFILES_DIR/warp" ~/.warp

# yabai
create_link "$DOTFILES_DIR/yabai" ~/.config/yabai

# skhd
create_link "$DOTFILES_DIR/skhd" ~/.config/skhd

# sketchybar
create_link "$DOTFILES_DIR/sketchybar" ~/.config/sketchybar

# nvim
create_link "$DOTFILES_DIR/nvim" ~/.config/nvim

# bat
create_link "$DOTFILES_DIR/bat" ~/.config/bat
echo "Building bat cache..."
bat cache --build

# yazi
create_link "$DOTFILES_DIR/yazi" ~/.config/yazi

# tmux
create_link "$DOTFILES_DIR/tmux" ~/.config/tmux

# leader-key
create_link "$DOTFILES_DIR/leader-key" ~/.config/leader-key

# vscode
create_link "$DOTFILES_DIR/vscode" ~/.config/vscode

# lazygit (only config.yml to avoid syncing state.yml)
mkdir -p ~/Library/Application\ Support/lazygit
if [ -L ~/Library/Application\ Support/lazygit/config.yml ] && [ "$(readlink ~/Library/Application\ Support/lazygit/config.yml)" = "$DOTFILES_DIR/lazygit/config.yml" ]; then
    echo "✓ ~/Library/Application Support/lazygit/config.yml is already linked correctly"
else
    echo "Creating link: ~/Library/Application Support/lazygit/config.yml -> $DOTFILES_DIR/lazygit/config.yml"
    ln -sf "$DOTFILES_DIR/lazygit/config.yml" ~/Library/Application\ Support/lazygit/config.yml
fi

echo "Dotfiles setup complete!"
