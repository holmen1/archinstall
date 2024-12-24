#!/bin/bash

# Define variables
CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SCRIPT_DIR="$CURRENT_DIR/scripts"
PACKAGES_DIR="$CURRENT_DIR/packages"
PKGLIST="$PACKAGES_DIR/pkglist.txt"
FOREIGN_PKGLIST="$PACKAGES_DIR/foreignpkglist.txt"

# Function to prompt the user
prompt_user() {
  local prompt_message=$1
  read -p "$prompt_message [Y/n]: " response
  response=${response:-Y}
  if [[ "$response" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Function to install yay
install_yay() {
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
}

#----------------------------------------------

# Prompt to configure Git
if prompt_user "Do you want to configure Git?"; then
  "$SCRIPT_DIR/gitconfig.sh"
fi

# Prompt to install yay
if prompt_user "Do you want to install yay?"; then
  install_yay
fi

# Prompt to install packages from pkglist.txt
if prompt_user "Do you want to install packages from pkglist.txt?"; then
  if [ ! -f "$PKGLIST" ]; then
    echo "pkglist.txt not found!"
    exit 1
  fi
  "$SCRIPT_DIR/install.sh" "$PKGLIST"
fi

# Prompt to install packages from foreignpkglist.txt
if prompt_user "Do you want to install packages from foreignpkglist.txt?"; then
  if [ ! -f "$FOREIGN_PKGLIST" ]; then
    echo "foreignpkglist.txt not found!"
    exit 1
  fi
  "$SCRIPT_DIR/install.sh" "$FOREIGN_PKGLIST"
fi

# Prompt to link the configuration files
if prompt_user "Do you want to link the configuration files?"; then
  "$SCRIPT_DIR/link_config.sh" "$CURRENT_DIR"
fi