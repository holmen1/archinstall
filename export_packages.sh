#!/bin/bash

# Define the output directory
OUTPUT_DIR=~/repos/dot-files/packages

# Export the list of explicitly installed packages
pacman -Qqetn > "$OUTPUT_DIR/pkglist.txt"
echo "Exported list of explicitly installed packages to $OUTPUT_DIR/pkglist.txt"

# Export the list of foreign packages (e.g., from AUR)
pacman -Qqem > "$OUTPUT_DIR/foreignpkglist.txt"
echo "Exported list of foreign packages to $OUTPUT_DIR/foreignpkglist.txt"