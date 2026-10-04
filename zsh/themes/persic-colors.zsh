# ==============================================
# ЦВЕТА (палитра Warm Pastel / Soft Espresso)
# ==============================================

# Основные оттенки палитры:
# #1f1a19 — Тёмный шоколадный/эбеновый фон (RGB: 31;26;25)
# #f2a49b — Персиково-коралловый (RGB: 242;164;155)
# #e4b3b2 — Пыльно-розовый (RGB: 228;179;178)
# #e5ca8f — Песочно-золотистый (RGB: 229;202;143)
# #d98880 — Приглушённый терракотовый / акцентный (RGB: 217;136;128)

CURRENT_BG='NONE'

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# --- Базовые цвета темы ---
C_UNKNOWN_TOKEN_FG=#e06c75

C_COMMAND_FG=#f2a49b
C_ALIAS_FG=#e5ca8f
C_FUNCTION_FG=#e4b3b2
C_BUILTIN_FG=#f2a49b

# Пути и строки — мягкий пыльно-розовый
C_PATH_FG=217
C_SINGLE_QUOTED_FG=217
C_DOUBLE_QUOTED_FG=217

# Опции (флаги, например -l) — песочно-золотистый
C_RESERVED_WORD_FG=222
C_PRECOMMAND_FG=222

# --- LS_COLORS / list-colors (RGB) ---
RGB_ROSE="242;164;155"
RGB_LILAC="229;202;143"

# di = директории (Коралл Bold)
# ex = исполняемые файлы (Золотистый Bold)
# ln = ссылки (Пыльно-розовый)
# ow = папки с правами записи для всех (Коралл)
# mi/or = битые ссылки (Мягкий красный/терракота)
LS_COLOR_DIR="1;38;2;${RGB_ROSE}"
LS_COLOR_EXEC="1;38;2;${RGB_LILAC}"
LS_COLOR_LINK="38;2;228;179;178"
LS_COLOR_SOCKET="38;2;${RGB_ROSE}"
LS_COLOR_FIFO="38;2;${RGB_ROSE}"
LS_COLOR_BLOCKDEV="38;2;${RGB_ROSE}"
LS_COLOR_CHARDEV="38;2;${RGB_ROSE}"
LS_COLOR_SETUID="1;38;2;${RGB_LILAC}"
LS_COLOR_SETGID="1;38;2;${RGB_LILAC}"
LS_COLOR_STICKY_OTHER_WRITABLE="38;2;${RGB_ROSE}"
LS_COLOR_OTHER_WRITABLE="38;2;${RGB_ROSE}"
LS_COLOR_STICKY="38;2;${RGB_ROSE}"
LS_COLOR_MISSING="38;2;217;136;128"
LS_COLOR_ORPHAN="38;2;217;136;128"

# ma (выбранный элемент):
# Фон = Коралл (#f2a49b) -> 48;2;242;164;155
# Текст = Тёмный эбеновый (#1f1a19) -> 38;2;31;26;25
LS_COLOR_SELECTED_BG="48;2;${RGB_ROSE}"
LS_COLOR_SELECTED_FG="38;2;31;26;25"
LS_COLOR_SELECTED="${LS_COLOR_SELECTED_BG};${LS_COLOR_SELECTED_FG}"

# --- Completion / zstyle ---
C_COMPLETION_DESCRIPTIONS_FG=222
C_COMPLETION_CORRECTIONS_FG=222
C_COMPLETION_MESSAGES_FG=210
C_COMPLETION_WARNINGS_FG=210

# --- Prompt: context ---
C_CONTEXT_SSH_BG=210
C_CONTEXT_SSH_FG=234
C_CONTEXT_LOCAL_BG=217
C_CONTEXT_LOCAL_FG=234

# --- Prompt: battery ---
C_BATTERY_HIGH_BG=222
C_BATTERY_MID_BG=217
C_BATTERY_LOW_BG=210
C_BATTERY_FG=234

# --- Prompt: git ---
C_GIT_DIRTY_BG=217
C_GIT_DIRTY_FG=234
C_GIT_CLEAN_BG=222
C_GIT_CLEAN_FG=234
C_GIT_MODIFIED_BG=210
C_GIT_MODIFIED_FG=255
C_GIT_DELETED_BG=167
C_GIT_DELETED_FG=255
C_GIT_STASH_BG=181
C_GIT_STASH_FG=234
C_GIT_PUSH_CLEAN_FG=234
C_GIT_PUSH_DIRTY_FG=255
C_GIT_PULL_FG=222

# --- Prompt: hg ---
C_HG_UNTRACKED_BG=210
C_HG_UNTRACKED_FG=255
C_HG_MODIFIED_BG=217
C_HG_MODIFIED_FG=234
C_HG_CLEAN_BG=222
C_HG_CLEAN_FG=234

# --- Prompt: dir ---
C_DIR_BG=204
C_DIR_FG=234

# --- Prompt: virtualenv ---
C_VIRTUALENV_BG=222
C_VIRTUALENV_FG=234

# --- Prompt: time ---
C_TIME_BG=197
C_TIME_FG=255

# --- Prompt: status ---
C_STATUS_BG=235
C_STATUS_ERROR_FG=210
C_STATUS_ROOT_FG=222
C_STATUS_JOBS_FG=217