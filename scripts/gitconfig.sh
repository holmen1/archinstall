#!/bin/bash

# Prompt for username and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Configure Git
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Generate SSH key
ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519 -N ""

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the SSH key to the ssh-agent
ssh-add ~/.ssh/id_ed25519
