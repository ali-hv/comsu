#!/bin/bash

# Detect package manager
if command -v apt-get &> /dev/null; then
    INSTALL_CMD="sudo apt-get update && sudo apt-get install -y jq"
elif command -v pacman &> /dev/null; then
    INSTALL_CMD="sudo pacman -S --noconfirm jq"
elif command -v dnf &> /dev/null; then
    INSTALL_CMD="sudo dnf install -y jq"
elif command -v brew &> /dev/null; then
    INSTALL_CMD="brew install jq"
else
    echo "Unsupported package manager."
    exit 1
fi

# Install jq if not already installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    eval "$INSTALL_CMD"
else
    echo "jq is already installed."
fi

# Create directory for shared files
SHARE_DIR="/usr/local/share/git-comsu"
if [ ! -d "$SHARE_DIR" ]; then
    sudo mkdir -p "$SHARE_DIR"
fi

# Copy prompt to the shared directory
sudo cp prompt "$SHARE_DIR/"

# Make git-comsu executable and copy to /usr/local/bin
sudo cp git-comsu /usr/local/bin/git-comsu
sudo chmod +x /usr/local/bin/git-comsu

echo
echo "Installation completed. You can now run 'git comsu'."
