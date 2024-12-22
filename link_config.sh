#!/bin/bash

# Define an array of source and target directories
links=(
    "~/repos/archinstall/dotfiles/hypr:~/.config/hypr"
    "~/repos/archinstall/dotfiles/waybar:~/.config/waybar"
    "~/repos/archinstall/dotfiles/dunst:~/.config/dunst"
    "~/repos/archinstall/dotfiles/rofi:~/.config/rofi"
    "~/repos/archinstall/dotfiles/wlogout:~/.config/wlogout"
#    "~/repos/archinstall/kitty:~/.config/kitty"
#   "~/repos/archinstall/nvim:~/.config/nvim"
#   "~/repos/dot-files/zsh:~/.config/zsh"
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
    ln -sfn "$source_expanded" "$target_expanded"
    
    echo "Symbolic link created from $source_expanded to $target_expanded"
done
