# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=2000
HISTFILESIZE=10000
shopt -s histappend

shopt -s globstar      # ** matches all files and subdirectories
shopt -s checkwinsize  # check window size after each command
shopt -s autocd        # auto cd by typing path

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

[ -f "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

BASH_CONFIG="$HOME/.config/bash"
[ -f "$BASH_CONFIG/aliases.sh" ] && . "$BASH_CONFIG/aliases.sh"

# fzf
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
  
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
    --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
    --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
    --color=selected-bg:#BCC0CC \
    --color=border:#9CA0B0,label:#4C4F69 \
    --style=full"
  
  fzf_history_widget() {
    local cmd
    cmd=$(history \
          | sed 's/^[ ]*[0-9]\+[ ]*//' \
          | sort | uniq -c | sort -nr \
          | awk '{$1=""; print substr($0,2)}' \
          | fzf)
    [[ -n "$cmd" ]] && READLINE_LINE="$cmd" && READLINE_POINT=${#READLINE_LINE}
  }
  bind -x '"\C-r": fzf_history_widget'
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
  export _ZO_DOCTOR=0
fi

# pnpm
export PNPM_HOME="/home/heng/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fnm
export FNM_PATH="/home/heng/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
  eval "$(fnm env --use-on-cd --shell bash)"
fi

PS1='[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\$ '
