#!/bin/bash
set -e

# Zsh
ln -sf zshrc ~/.zshrc
ln -sf .p10k.zsh ~/.p10k.zsh

# Neovim
mkdir -p ~/.config/nvim
ln -sf /nvim/init.lua ~/.config/nvim/init.lua

# Git
ln -sf /git/.gitconfig ~/.gitconfig
