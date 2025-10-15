#!/usr/bin/env bash

sudoer="$(grep ':1000:1000:' /etc/passwd | cut -d':' -f1)"

print_err() {
    local RED='\033[0;31m'
    local RESET='\033[0m'
    echo -e ${RED}${1}${RESET}
}

[ ! "$UID" -eq 0 ] && print_err "You must run this script as root." && exit 1

# Update package lists and install software
echo "Updating package lists and installing software..."
apt-get update && apt-get upgrade
apt-get install -y \
    aptitude \
    bear \
    build-essential \
    ca-certificates \
    curl \
    fastfetch \
    fzf \
    git \
    gnupg \
    lsb-release \
    man-db \
    net-tools \
    python3 \
    stow \
    tmux \
    unzip \
    valgrind \
    vim \
    wget \
    whiptail \
    xz-utils \
    zip \
    zoxide

# Add Docker's official GPG key and set up the repository
echo "Setting up Docker repository..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
    \

apt-get update
apt-get install -y \
    containerd.io \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \

usermod "$sudoer" -aG docker

bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
