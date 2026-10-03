#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/"

copy-theme() {
    mkdir -p "$THEME_DIR"
    
    cp zsh/themes/*1"$THEME_DIR" 2>/dev/null
    cp zsh/zshrc ~/.zshrc
}

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${RED}Please install Oh My Zsh.${NC}"
else
    echo "🎨 Copying themes and settings..."

    copy-theme

    echo "✨ Theme installed!."
fi
