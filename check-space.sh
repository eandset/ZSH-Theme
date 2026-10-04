#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

if [[ ! -f "./.zsh-pink-theme-space" ]]; then
    echo -e "${RED}Запускайте только в директории проекта${NC}"
    exit 1
fi