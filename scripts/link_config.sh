#!/bin/bash

# Check if the base directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <base-directory>"
  exit 1
fi

BASE_DIR="$1"

# Define an array of source and target directories
links=(
    "$BASE_DIR/dotfiles/hypr:~/.config/hypr"
    "$BASE_DIR/dotfiles/waybar:~/.config/waybar"
    "$BASE_DIR/dotfiles/wlogout:~/.config/wlogout"
    "$BASE_DIR/dotfiles/rofi:~/.config/rofi"
    "$BASE_DIR/dotfiles/nvim:~/.config/nvim"
#    "$BASE_DIR/kitty:~/.config/kitty"
#    "$BASE_DIR/zsh:~/.config/zsh"
)

# Create the symbolic links
for link in "${links[@]}"; do
    source="${link%%:*}"
    target="${link##*:}"
    
    # Expand ~ to the home directory
    source_expanded=$(eval echo $source)
    target_expanded=$(eval echo $target)
   
    # Remove the target if it is an existing directory or symlink
    if [ -d "$target_expanded" ] || [ -L "$target_expanded" ]; then
        rm -rf "$target_expanded"
    fi

    # Create the symbolic link
    ln -s "$source_expanded" "$target_expanded"
    if [ $? -eq 0 ]; then
        echo "Created symbolic link: $target_expanded -> $source_expanded"
    else
        echo "Failed to create symbolic link: $target_expanded -> $source_expanded"
    fi
done
