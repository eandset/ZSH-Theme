# vim:ft=zsh ts=2 sw=2 sts=2
#
# Pink Theme - Based on agnoster's Theme
# A Powerline-inspired theme for ZSH in pink tones
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# ==============================================
# ЦВЕТА (именованные)
# ==============================================

# --- Базовые цвета темы ---
C_UNKNOWN_TOKEN_FG=#f52742

C_COMMAND_FG=#f788ba
C_ALIAS_FG=#e888f7
C_FUNCTION_FG=#aa78fa
C_BUILTIN_FG=#f788ba

# Пути и строки - цвет 218 (светло-розовый)
C_PATH_FG=218
C_SINGLE_QUOTED_FG=218
C_DOUBLE_QUOTED_FG=218

# Опции (флаги, например -l) - цвет 205 (средний розовый)
C_RESERVED_WORD_FG=205
C_PRECOMMAND_FG=205

# --- LS_COLORS / list-colors (RGB) ---
# #f788ba (Rose)  -> 247;136;186
# #e888f7 (Lilac) -> 232;136;247
RGB_ROSE="247;136;186"
RGB_LILAC="232;136;247"

# di = директории (Rose Bold)
# ex = исполняемые файлы (Lilac Bold)
# ln = ссылки (Lilac)
# ow = папки с правами записи для всех (подсвечиваем Rose)
# mi/or = битые ссылки (Красный, чтобы было видно ошибку)
LS_COLOR_DIR="1;38;2;${RGB_ROSE}"
LS_COLOR_EXEC="1;38;2;${RGB_LILAC}"
LS_COLOR_LINK="38;2;${RGB_LILAC}"
LS_COLOR_SOCKET="38;2;${RGB_ROSE}"
LS_COLOR_FIFO="38;2;${RGB_ROSE}"
LS_COLOR_BLOCKDEV="38;2;${RGB_ROSE}"
LS_COLOR_CHARDEV="38;2;${RGB_ROSE}"
LS_COLOR_SETUID="1;38;2;${RGB_LILAC}"
LS_COLOR_SETGID="1;38;2;${RGB_LILAC}"
LS_COLOR_STICKY_OTHER_WRITABLE="38;2;${RGB_ROSE}"
LS_COLOR_OTHER_WRITABLE="38;2;${RGB_ROSE}"
LS_COLOR_STICKY="38;2;${RGB_ROSE}"
LS_COLOR_MISSING="1;31"
LS_COLOR_ORPHAN="1;31"

# ma (выбранный элемент):
# Фон = #f788ba (Rose) -> 48;2;247;136;186
# Текст = Черный (для контракта на светлом фоне) -> 38;5;0
LS_COLOR_SELECTED_BG="48;2;${RGB_ROSE}"
LS_COLOR_SELECTED_FG="38;5;0"
LS_COLOR_SELECTED="${LS_COLOR_SELECTED_BG};${LS_COLOR_SELECTED_FG}"

# --- Completion / zstyle ---
C_COMPLETION_DESCRIPTIONS_FG=213
C_COMPLETION_CORRECTIONS_FG=213
C_COMPLETION_MESSAGES_FG=197
C_COMPLETION_WARNINGS_FG=197

# --- Prompt: context ---
C_CONTEXT_SSH_BG=213
C_CONTEXT_SSH_FG=white
C_CONTEXT_LOCAL_BG=218
C_CONTEXT_LOCAL_FG=161

# --- Prompt: battery ---
C_BATTERY_HIGH_BG=211
C_BATTERY_MID_BG=217
C_BATTERY_LOW_BG=197
C_BATTERY_FG=white

# --- Prompt: git ---
C_GIT_DIRTY_BG=217
C_GIT_DIRTY_FG=89
C_GIT_CLEAN_BG=211
C_GIT_CLEAN_FG=white
C_GIT_MODIFIED_BG=197
C_GIT_MODIFIED_FG=white
C_GIT_DELETED_BG=161
C_GIT_DELETED_FG=white
C_GIT_STASH_BG=205
C_GIT_STASH_FG=white
C_GIT_PUSH_CLEAN_FG=89
C_GIT_PUSH_DIRTY_FG=white
C_GIT_PULL_FG=213

# --- Prompt: hg ---
C_HG_UNTRACKED_BG=197
C_HG_UNTRACKED_FG=white
C_HG_MODIFIED_BG=217
C_HG_MODIFIED_FG=89
C_HG_CLEAN_BG=211
C_HG_CLEAN_FG=white

# --- Prompt: dir ---
C_DIR_BG=213
C_DIR_FG=white

# --- Prompt: virtualenv ---
C_VIRTUALENV_BG=219
C_VIRTUALENV_FG=89

# --- Prompt: time ---
C_TIME_BG=205
C_TIME_FG=white

# --- Prompt: status ---
C_STATUS_BG=89
C_STATUS_ERROR_FG=197
C_STATUS_ROOT_FG=213
C_STATUS_JOBS_FG=219
