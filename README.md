# ZSH-Theme

Моя ZSH (oh my zsh) тема для терминала - kitty, konsole и другие.

## Инструкция по установке
1. Склонировать репозиторий `git clone https://github.com/eandset/ZSH-Theme.git` или же скачать архив и распаковать
2. Перейти в директорию `cd ZSH-Theme`
3. Дать права на запуск, если они не были выданы `chmod +x *.sh`
4. Запустить `./install.sh`
5. Готово, у вас установлена тема на `zsh`, `oh my zsh` и шрифт `JetBrainsMono`

### Опциональная установка
> После установки вы можете сделать следующее если требуется:
1. `./fastfetch-config-install.sh` - позволяет установить конфиги для **fastfetch**. Сам **fastfetch** необходимо поставить в ручную
2. Установить профиль для терминала
> Чтобы сменить глобально **bash** на **zsh** (нужна права _sudo_) - `chsh -s $(which zsh)`

> Можете воспользоваться одним из установщиков конфига/профиля для терминала (без прав _sudo_)
- [x] konsole - `./konsole-profile-install.sh`
- [ ] kitty
- [ ] alacritty
- [ ] gnome terminal
3. Подредактироать `~/.zshrc`. можете раскомментировать некоторые команды, если нужно 
```
...

plugins=(
...
    # archlinux
...
)

...

# Set-up icons for files/directories in terminal using lsd
# alias ls='lsd'
# alias l='ls -l'
# alias la='ls -a'
# alias lla='ls -la'
# alias lt='ls --tree'

# Simpler
# alias cd="z"

# Binds
# source <(fzf --zsh) # Set-up FZF key bindings (CTRL R for fuzzy history finder)

...
```

## Шаблон устаноки для Konsole
```bash
git clone https://github.com/eandset/ZSH-Theme.git

cd ZSH-Theme
chmod +x *.sh

./install.sh
./konsole-profile-install.sh
```

Наслаждайтесь темой для Oh My ZSH!
