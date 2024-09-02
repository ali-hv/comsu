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

# Copy prompt.txt to the shared directory
echo "Copying prompt.txt to $SHARE_DIR..."
sudo cp prompt.txt "$SHARE_DIR/"

# Make comsu.sh executable and copy it to /usr/local/bin
echo "Installing comsu script to /usr/local/bin..."
sudo cp comsu.sh /usr/local/bin/comsu
sudo chmod +x /usr/local/bin/comsu

echo "Installation complete. You can now run 'comsu' command."
