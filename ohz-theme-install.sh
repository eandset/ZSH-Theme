#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/"

copy-theme() {
    mkdir -p "$THEME_DIR" && echo "[INFO] Created theme directory"
    
    cp zsh/themes/* "$THEME_DIR" && echo "[INFO] Copped themes"
    cp zsh/zshrc ~/.zshrc && echo "[INFO] Copped zshrc file"
}

if [ -d "$HOME/.oh-my-zsh" ]; then

    ./check-space.sh || exit 1
    
    echo "🎨 Copying themes and settings..."

    copy-theme

    echo "✨ Theme installed!."
else
    echo -e "${RED}Please install Oh My Zsh.${NC}"
fi
