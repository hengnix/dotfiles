# ~/.config/bash/aliases.sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -l'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline --graph --decorate --all'
alias gs='git status -sb'

# use the 1Password SSH agent on Windows host
alias ssh='ssh.exe'
alias ssh-add='ssh-add.exe'
