#!/bin/bash

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🚀 Installing Oh My Zsh..."
    
    export RUNZSH=no
    export CHSH=no
    
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "ℹ️ Oh My Zsh is already installed."
fi