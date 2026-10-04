#!/bin/bash

# 1. Пути и переменные
KONSOLE_DIR="$HOME/.local/share/konsole"
CONFIG_DIR="$HOME/.config"
THEME_NAME="MyCustomTheme"
PROFILE_NAME="ZSH"

# Создаем директорию для конфигурации, если её нет
mkdir -p "$KONSOLE_DIR"

# 2. Создаем файл цветовой схемы (.colorscheme)
# Путь к исходному файлу темы
THEME_SOURCE="konsole/my_theme.toml"

cp "$THEME_SOURCE" "$KONSOLE_DIR/$THEME_NAME.colorscheme" \
    && echo "Тема успешно создана в $KONSOLE_DIR/$THEME_NAME.colorscheme"

# 3. Создаем конфигурацию профиля ZSH (.profile)
# Используем имя файла "ZSH.profile" — Konsole связывает имя профиля с именем файла
cat << EOF > "$KONSOLE_DIR/$PROFILE_NAME.profile"
[Appearance]
ColorScheme=$THEME_NAME
Font=JetBrains Mono,11,-1,5,50,0,0,0,0,0

[General]
Command=/bin/zsh
Name=$PROFILE_NAME
Parent=FALLBACK/

[X-Profiles]
Name=ZSH
EOF

echo "✓ Профиль '$PROFILE_NAME' настроен (Шрифт: JetBrains Mono, Команда: /bin/zsh)."

# 4. Назначаем созданный профиль дефолтным для Konsole
KONSOLE_RC="$CONFIG_DIR/konsolerc"

if [ -f "$KONSOLE_RC" ]; then
    # Настраиваем дефолтный профиль в секции [Desktop Entry]
    if grep -q "\[Desktop Entry\]" "$KONSOLE_RC"; then
        if grep -q "DefaultProfile=" "$KONSOLE_RC"; then
            sed -i "s/DefaultProfile=.*/DefaultProfile=$PROFILE_NAME.profile/" "$KONSOLE_RC"
        else
            sed -i "/\[Desktop Entry\]/a DefaultProfile=$PROFILE_NAME.profile" "$KONSOLE_RC"
        fi
    else
        cat << EOF >> "$KONSOLE_RC"

[Desktop Entry]
DefaultProfile=$PROFILE_NAME.profile
EOF
    fi
else
    # Если файла настроек вообще нет
    cat << EOF > "$KONSOLE_RC"
[Desktop Entry]
DefaultProfile=$PROFILE_NAME.profile
EOF
fi

echo "✓ Профиль '$PROFILE_NAME' установлен по умолчанию для новых окон Konsole."
echo "Внимание: Убедитесь, что шрифт 'JetBrains Mono' установлен в вашей системе."
