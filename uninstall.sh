#!/bin/bash

# Remove shared directory
SHARE_DIR="/usr/local/share/git-comsu"
if [ -d "$SHARE_DIR" ]; then
    sudo rm -rf "$SHARE_DIR"
fi

# Remove git-comsu executable
if [ -f "/usr/local/bin/git-comsu" ]; then
    sudo rm "/usr/local/bin/git-comsu"
fi

echo
echo "Uninstallation completed."