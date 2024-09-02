#!/bin/bash

# Check if jq is installed; if not, install it
if ! command -v jq &> /dev/null; then
    echo "jq not found, installing..."
    sudo apt-get update
    sudo apt-get install -y jq
else
    echo "jq is already installed."
fi

# Create a directory for shared files
SHARE_DIR="/usr/local/share/comsu"
if [ ! -d "$SHARE_DIR" ]; then
    echo "Creating directory for shared files at $SHARE_DIR..."
    sudo mkdir -p "$SHARE_DIR"
fi

# Copy prompt to the shared directory
echo "Copying prompt file to $SHARE_DIR..."
sudo cp prompt "$SHARE_DIR/"

# Make comsu.sh executable and copy it to /usr/local/bin
echo "Installing comsu script to /usr/local/bin..."
sudo cp comsu /usr/local/bin/comsu
sudo chmod +x /usr/local/bin/comsu

echo
echo "Installation completed. You can now run 'comsu' command."
