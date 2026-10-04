#!/bin/bash

OHZ_PATH="$HOME/.oh-my-zsh/"

cp zsh/RandomFastfetchIcon.sh "${OHZ_PATH}"
chmod +x "${OHZ_PATH}/RandomFastfetchIcon.sh"

cp -r fastfetch/ ~/.config/