#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# zsh
mv ~/.zshrc ~/.zshrc.bak
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

# starship
rm -rf ~/.config/starship
ln -sf "$DOTFILES_DIR/starship" ~/.config/starship

# ghostty
rm -rf ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty" ~/.config/ghostty

# warp
rm -rf ~/.warp
ln -sf "$DOTFILES_DIR/warp" ~/.warp

# yabai
rm -rf ~/.config/yabai
ln -sf "$DOTFILES_DIR/yabai" ~/.config/yabai

# skhd
rm -rf ~/.config/skhd
ln -sf "$DOTFILES_DIR/skhd" ~/.config/skhd

# sketchybar
rm -rf ~/.config/sketchybar
ln -sf "$DOTFILES_DIR/sketchybar" ~/.config/sketchybar

# nvim
rm -rf ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim

# bat
rm -rf ~/.config/bat
ln -sf "$DOTFILES_DIR/bat" ~/.config/bat
bat cache --build

# yazi
rm -rf ~/.config/yazi
ln -sf "$DOTFILES_DIR/yazi" ~/.config/yazi

# tmux
rm -rf ~/.config/tmux
ln -sf "$DOTFILES_DIR/tmux" ~/.config/tmux

# leader-key
rm -rf ~/.config/leader-key
ln -sf "$DOTFILES_DIR/leader-key" ~/.config/leader-key

# vscode
rm -rf ~/.config/vscode
ln -sf "$DOTFILES_DIR/vscode" ~/.config/vscode
