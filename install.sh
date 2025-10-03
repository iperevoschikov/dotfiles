#!/usr/bin/env bash
set -e

# Путь к папке, где лежит сам скрипт
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Using dotfiles from: $DOTFILES_DIR"

# --- Установка Zsh ---
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing Zsh..."

  if [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt install -y zsh
  elif [ -f /etc/redhat-release ]; then
    sudo dnf install -y zsh || sudo yum install -y zsh
  elif command -v brew >/dev/null 2>&1; then
    brew install zsh
  else
    echo "❌ Could not detect package manager. Please install zsh manually."
    exit 1
  fi
else
  echo "Zsh already installed."
fi

# --- Сделать Zsh оболочкой по умолчанию ---
if [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

# --- Симлинки ---
# Zsh
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# .config
ln -sfn "$DOTFILES_DIR/.config" ~/.config

# Git
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# --- Плагины ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

echo "✅ Done! Please restart your terminal."
