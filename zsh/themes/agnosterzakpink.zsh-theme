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

source "${ZSH_CUSTOM:-$ZSH/custom}/themes/eandset/pink-colors.zsh"

# ==============================================
# ПРИМЕНЕНИЕ ЦВЕТОВ
# ==============================================

ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${C_UNKNOWN_TOKEN_FG}"

ZSH_HIGHLIGHT_STYLES[command]="fg=${C_COMMAND_FG}"
ZSH_HIGHLIGHT_STYLES[alias]="fg=${C_ALIAS_FG}"
ZSH_HIGHLIGHT_STYLES[function]="fg=${C_FUNCTION_FG}"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=${C_BUILTIN_FG}"

# Пути и строки - цвет 218
ZSH_HIGHLIGHT_STYLES[path]="fg=${C_PATH_FG},underline"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=${C_SINGLE_QUOTED_FG}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=${C_DOUBLE_QUOTED_FG}"

# Опции (флаги, например -l) - цвет 205
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${C_RESERVED_WORD_FG}"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${C_PRECOMMAND_FG}"

# ==============================================
# НАСТРОЙКА ЦВЕТОВ
# ==============================================

export LS_COLORS="di=${LS_COLOR_DIR}:ex=${LS_COLOR_EXEC}:ln=${LS_COLOR_LINK}:so=${LS_COLOR_SOCKET}:pi=${LS_COLOR_FIFO}:bd=${LS_COLOR_BLOCKDEV}:cd=${LS_COLOR_CHARDEV}:su=${LS_COLOR_SETUID}:sg=${LS_COLOR_SETGID}:tw=${LS_COLOR_STICKY_OTHER_WRITABLE}:ow=${LS_COLOR_OTHER_WRITABLE}:st=${LS_COLOR_STICKY}:mi=${LS_COLOR_MISSING}:or=${LS_COLOR_ORPHAN}"

# Применяем эти цвета к меню выбора (TAB)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" "ma=${LS_COLOR_SELECTED}"

# 3. Настройка заголовков групп (например, "-- Commands --")
zstyle ':completion:*:*:*:*:descriptions' format "%F{${C_COMPLETION_DESCRIPTIONS_FG}}-- %d --%f"
zstyle ':completion:*:*:*:*:corrections' format "%F{${C_COMPLETION_CORRECTIONS_FG}}!- %d (errors: %e) -!%f"
zstyle ':completion:*:messages' format " %F{${C_COMPLETION_MESSAGES_FG}} -- %d --%f"
zstyle ':completion:*:warnings' format " %F{${C_COMPLETION_WARNINGS_FG}} -- No matches found --%f"

# 4. Группировка результатов (сначала файлы, потом папки и т.д.)
zstyle ':completion:*' group-name ''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    print -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    # SSH session
    prompt_segment $C_CONTEXT_SSH_BG $C_CONTEXT_SSH_FG "%{$fg_bold[white]%(!.%{%F{white}%}.)%}$USER@%m%{$fg_no_bold[white]%}"
  else
    # Локальная сессия
    prompt_segment $C_CONTEXT_LOCAL_BG $C_CONTEXT_LOCAL_FG "%{$fg_bold[161]%(!.%{%F{161]%}.)%}@$USER%{$fg_no_bold[161]%}"
  fi
}

# Battery Level
prompt_battery() {
  HEART='♥ '

  if [[ $(uname) == "Darwin" ]] ; then

    function battery_is_charging() {
      [ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]
    }

    function battery_pct() {
      local smart_battery_status="$(ioreg -rc "AppleSmartBattery")"
      typeset -F maxcapacity=$(echo $smart_battery_status | grep '^.*"MaxCapacity"\ =\ ' | sed -e 's/^.*"MaxCapacity"\ =\ //')
      typeset -F currentcapacity=$(echo $smart_battery_status | grep '^.*"CurrentCapacity"\ =\ ' | sed -e 's/^.*CurrentCapacity"\ =\ //')
      integer i=$(((currentcapacity/maxcapacity) * 100))
      echo $i
    }

    function battery_pct_remaining() {
      if battery_is_charging ; then
        battery_pct
      else
        echo "External Power"
      fi
    }

    function battery_time_remaining() {
      local smart_battery_status="$(ioreg -rc "AppleSmartBattery")"
      if [[ $(echo $smart_battery_status | grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]] ; then
        timeremaining=$(echo $smart_battery_status | grep '^.*"AvgTimeToEmpty"\ =\ ' | sed -e 's/^.*"AvgTimeToEmpty"\ =\ //')
        if [ $timeremaining -gt 720 ] ; then
          echo "::"
        else
          echo "~$((timeremaining / 60)):$((timeremaining % 60))"
        fi
      fi
    }

    b=$(battery_pct_remaining)
    if [[ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]] ; then
      if [ $b -gt 50 ] ; then
        prompt_segment $C_BATTERY_HIGH_BG $C_BATTERY_FG
      elif [ $b -gt 20 ] ; then
        prompt_segment $C_BATTERY_MID_BG $C_BATTERY_FG
      else
        prompt_segment $C_BATTERY_LOW_BG $C_BATTERY_FG
      fi
      echo -n "%{$fg_bold[white]%}$HEART$(battery_pct_remaining)%%%{$fg_no_bold[white]%}"
    fi
  fi

  if [[ $(uname) == "Linux" && -d /sys/module/battery ]] ; then

    function battery_is_charging() {
      ! [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]]
    }

    function battery_pct() {
      if (( $+commands[acpi] )) ; then
        echo "$(acpi | cut -f2 -d ',' | tr -cd '[:digit:]')"
      fi
    }

    function battery_pct_remaining() {
      if [ ! $(battery_is_charging) ] ; then
        battery_pct
      else
        echo "External Power"
      fi
    }

    function battery_time_remaining() {
      if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
        echo $(acpi | cut -f3 -d ',')
      fi
    }

    b=$(battery_pct_remaining)
    if [[ $(acpi 2&>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
      if [ $b -gt 40 ] ; then
        prompt_segment $C_BATTERY_HIGH_BG $C_BATTERY_FG
      elif [ $b -gt 20 ] ; then
        prompt_segment $C_BATTERY_MID_BG $C_BATTERY_FG
      else
        prompt_segment $C_BATTERY_LOW_BG $C_BATTERY_FG
      fi
      echo -n "%{$fg_bold[white]%}$HEART$(battery_pct_remaining)%%%{$fg_no_bold[white]%}"
    fi

  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
#«»±˖˗‑‐‒ ━ ✚‐↔←↑↓→↭⇎⇔⋆━◂▸◄►◆☀★☗☊✔✖❮❯⚑⚙
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR="$BRANCH"
  }
  local ref dirty mode repo_path clean has_upstream
  local modified untracked added deleted tagged stashed
  local ready_commit git_status bgclr fgclr
  local commits_diff commits_ahead commits_behind has_diverged to_push to_pull

  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    git_status=$(git status --porcelain 2> /dev/null)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      clean=''
      bgclr=$C_GIT_DIRTY_BG
      fgclr=$C_GIT_DIRTY_FG
    else
      clean=' ✔'
      bgclr=$C_GIT_CLEAN_BG
      fgclr=$C_GIT_CLEAN_FG
    fi

    local upstream=$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
    if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then has_upstream=true; fi

    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)

    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files☀"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added=" $number_added✚"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified=" $number_modified●"
      bgclr=$C_GIT_MODIFIED_BG
      fgclr=$C_GIT_MODIFIED_FG
    fi

    local number_added_modified=$(\grep -c "^M" <<< "${git_status}")
    local number_added_renamed=$(\grep -c "^R" <<< "${git_status}")
    if [[ $number_modified -gt 0 && $number_added_modified -gt 0 ]]; then
      modified="$modified$((number_added_modified+number_added_renamed))±"
    elif [[ $number_added_modified -gt 0 ]]; then
      modified=" ●$((number_added_modified+number_added_renamed))±"
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted=" $number_deleted‒"
      bgclr=$C_GIT_DELETED_BG
      fgclr=$C_GIT_DELETED_FG
    fi

    local number_added_deleted=$(\grep -c "^D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 && $number_added_deleted -gt 0 ]]; then
      deleted="$deleted$number_added_deleted±"
    elif [[ $number_added_deleted -gt 0 ]]; then
      deleted=" ‒$number_added_deleted±"
    fi

    local tag_at_current_commit=$(git describe --exact-match --tags $current_commit_hash 2> /dev/null)
    if [[ -n $tag_at_current_commit ]]; then tagged=" ☗$tag_at_current_commit "; fi

    local number_of_stashes="$(git stash list -n1 2> /dev/null | wc -l)"
    if [[ $number_of_stashes -gt 0 ]]; then
      stashed=" ${number_of_stashes##*(  )}⚙"
      bgclr=$C_GIT_STASH_BG
      fgclr=$C_GIT_STASH_FG
    fi

    if [[ $number_added -gt 0 || $number_added_modified -gt 0 || $number_added_deleted -gt 0 ]]; then ready_commit=' ⚑'; fi

    local upstream_prompt=''
    if [[ $has_upstream == true ]]; then
      commits_diff="$(git log --pretty=oneline --topo-order --left-right ${current_commit_hash}...${upstream} 2> /dev/null)"
      commits_ahead=$(\grep -c "^<" <<< "$commits_diff")
      commits_behind=$(\grep -c "^>" <<< "$commits_diff")
      upstream_prompt="$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)"
      upstream_prompt=$(sed -e 's/\/.*$/ ☊ /g' <<< "$upstream_prompt")
    fi

    has_diverged=false
    if [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]]; then has_diverged=true; fi
    if [[ $has_diverged == false && $commits_ahead -gt 0 ]]; then
      if [[ $bgclr == $C_GIT_MODIFIED_BG || $bgclr == $C_GIT_STASH_BG || $bgclr == $C_GIT_DELETED_BG ]] then
        to_push=" $fg_bold[white]↑$commits_ahead$fg_bold[$fgclr]"
      else
        to_push=" $fg_bold[${C_GIT_PUSH_CLEAN_FG}]↑$commits_ahead$fg_bold[$fgclr]"
      fi
    fi
    if [[ $has_diverged == false && $commits_behind -gt 0 ]]; then to_pull=" $fg_bold[${C_GIT_PULL_FG}]↓$commits_behind$fg_bold[$fgclr]"; fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    prompt_segment $bgclr $fgclr

    print -n "%{$fg_bold[$fgclr]%}${ref/refs\/heads\//$PL_BRANCH_CHAR $upstream_prompt}${mode}$to_push$to_pull$clean$tagged$stashed$untracked$modified$deleted$added$ready_commit%{$fg_no_bold[$fgclr]%}"
  fi
}

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment $C_HG_UNTRACKED_BG $C_HG_UNTRACKED_FG
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment $C_HG_MODIFIED_BG $C_HG_MODIFIED_FG
        st='±'
      else
        # if working copy is clean
        prompt_segment $C_HG_CLEAN_BG $C_HG_CLEAN_FG
      fi
      print -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment $C_HG_UNTRACKED_BG $C_HG_UNTRACKED_FG
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment $C_HG_MODIFIED_BG $C_HG_MODIFIED_FG
        st='±'
      else
        prompt_segment $C_HG_CLEAN_BG $C_HG_CLEAN_FG
      fi
      print -n "☿ $rev@$branch" $st
    fi
  fi
}

#Dir: current working directory
prompt_dir() {
  prompt_segment $C_DIR_BG $C_DIR_FG "%{$fg_bold[white]%}%~%{$fg_no_bold[white]%}"
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment $C_VIRTUALENV_BG $C_VIRTUALENV_FG "(`basename $virtualenv_path`)"
  fi
}

prompt_time() {
  prompt_segment $C_TIME_BG $C_TIME_FG "%{$fg_bold[white]%}%D{%a %e %b - %H:%M}%{$fg_no_bold[white]%}"
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{${C_STATUS_ERROR_FG}}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{${C_STATUS_ROOT_FG}}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{${C_STATUS_JOBS_FG}}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $C_STATUS_BG default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  print -n "\n"
  prompt_status
  #prompt_battery
  prompt_time
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
  CURRENT_BG='NONE'
  print -n "\n"
  prompt_context
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '