#!/usr/bin/env bash
set -e

# Путь к папке, где лежит сам скрипт
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Using dotfiles from: $DOTFILES_DIR"

# Zsh
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# .config
ln -sfn "$DOTFILES_DIR/.config" ~/.config

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

# Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

echo "✅ Done!"
