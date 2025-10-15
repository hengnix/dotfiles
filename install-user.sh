#!/usr/bin/env bash

DOTFILES_REMOTE="https://github.com/hengnix/dotfiles"
DOTFILES_LOCAL="${HOME}/dotfiles"

print_err() {
    local RED='\033[0;31m'
    local RESET='\033[0m'
    echo -e ${RED}${1}${RESET}
}

[ ! -z "$SUDO_USER" ] && print_err "You can't run this script as root." \
    && exit 1

# Create cache, local, and config directories
mkdir -p ${HOME}/.cache
mkdir -p ${HOME}/.local/{share,state}
mkdir -p ${HOME}/.config/{bash,fastfetch,tmux}

rm -f ${HOME}/.bash_profile ${HOME}/.bashrc

curl -fsSL https://fnm.vercel.app/install | bash

curl -fsSL https://get.pnpm.io/install.sh | sh -

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

[ ! -d "$DOTFILES_LOCAL" ] && \
    git clone $DOTFILES_REMOTE $DOTFILES_LOCAL

echo "Running stow to create symlinks..."
cd "$DOTFILES_LOCAL" && stow -R -t $HOME . --adopt
