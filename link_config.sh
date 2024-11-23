#!/bin/bash

# Define an array of source and target directories
links=(
    "~/repos/dot-files/kitty:~/.config/kitty"
    "~/repos/dot-files/nvim:~/.config/nvim"
#   "~/repos/dot-files/zsh:~/.config/zsh"
)

# Create the symbolic links
for link in "${links[@]}"; do
    source="${link%%:*}"
    target="${link##*:}"
    
    # Expand ~ to the home directory
    source_expanded=$(eval echo $source)
    target_expanded=$(eval echo $target)
    
    # Create the symbolic link
    ln -sfn "$source_expanded" "$target_expanded"
    
    echo "Symbolic link created from $source_expanded to $target_expanded"
done