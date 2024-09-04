#!/usr/bin/env bash

# Get the folder where the script is located
MYFOLDER=$(dirname "$(realpath "$0")")

# Error codes
E_OS_NOT_IDENTIFIED=1
E_JQ_NOT_FOUND=2
E_PROMPT_CREATION_FAIL=3
E_GIT_COMSU_CREATION_FAIL=4
E_PERMISSION_FAIL=5
E_FAIL_INSTALL_JQ=6
E_BREW_IS_NOT_INSTALLED=7


# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Error handling function
error_exit() {
    echo "$1" >&2
    exit "${2:-1}" # Default exit status is 1 if not provided
}

# Function to check if two directories are on the same filesystem
check_same_filesystem() {
    dir1="$1"
    dir2="$2"
    
    # Get the filesystem device for each directory
    fs1=$( df "$dir1" | tail  -1 | awk '{print $1}')
    fs2=$( df "$dir2" | tail  -1 | awk '{print $1}')
    
    # Compare the filesystem devices
    if [[ "$fs1" == "$fs2" ]]; then
        return 0 # Same filesystem
    else
        return 1 # Different filesystems
    fi
}

# Package installers
install_requirements_mac() {
    if ! command_exists brew; then
        error_exit "Homebrew is not installed. Please install it from https://brew.sh/." $E_BREW_IS_NOT_INSTALLED
    fi
    brew install jq awk
}

install_requirements_debian(){
    sudo apt-get update -y && sudo apt-get install -y jq || error_exit "Can not install jq" $E_FAIL_INSTALL_JQ
}

install_requirements_fedora(){
    sudo dnf update -y && sudo dnf install -y jq || error_exit "Can not install jq" $E_FAIL_INSTALL_JQ
}

install_requirements_arch(){
    sudo pacman -Syu --noconfirm jq || error_exit "Can not install jq" $E_FAIL_INSTALL_JQ
}

MYOS="unknown"
SUDO="sudo"
SHARE_DIR="/usr/local/share/git-comsu"

# Identify the OS and set the MYOS variable and set proper folder for install
if [[ "$OSTYPE" == "darwin"* ]]; then
    MYOS="mac"  # macOS
    SUDO=""
    SHARE_DIR="${HOME}/.local/bin/git-comsu"
elif [[ -f /etc/debian_version ]]; then
    MYOS="debian"  # Debian-based
elif [[ -f /etc/fedora-release ]]; then
    MYOS="fedora"  # Fedora-based
elif command_exists pacman; then
    MYOS="arch"  # Arch-based (if pacman is available)
else
    error_exit "OS not identified. Supported OS types are macOS, Debian-based (include Ubuntu), Fedora-based, and Arch-based systems." $E_OS_NOT_IDENTIFIED
fi

# Output the result
echo "Operating System identified as: $MYOS"

# Check target folder is in the same file system of source files
CREATE_COMMAND="ln"
if ! check_same_filesystem "$MYFOLDER" "$SHARE_DIR"; then
    CREATE_COMMAND="cp"
    echo "Note: $MYFOLDER and $SHARE_DIR are on different filesystems. Will use copy."
fi

# Check if jq is installed; if not, install it
if ! command_exists jq; then
    echo "jq not found, installing..."
    install_requirements_${MYOS}
    if ! command_exists jq; then
        error_exit "Even after install jq can not find it. check it and try again. It is a requirement." $E_JQ_NOT_FOUND
    fi
else
    echo "jq is already installed."
fi

# Create a directory for shared files
if [ ! -d "$SHARE_DIR" ]; then
    echo "Creating directory for shared files at ${SHARE_DIR} ..."
    $SUDO mkdir -p "${SHARE_DIR}"
fi

# Copy prompt to the shared directory
if [ ! -f "${SHARE_DIR}/prompt" ]; then
    echo "Creating prompt file in ${SHARE_DIR} ..."
    $SUDO $CREATE_COMMAND "${MYFOLDER}/prompt" "${SHARE_DIR}/prompt" || error_exit "cannot create prompt file" $E_PROMPT_CREATION_FAIL
fi

# Make git-comsu executable and copy it to /usr/local/bin
echo "Installing git-comsu script to ${SHARE_DIR} ..."
if [ ! -f "${SHARE_DIR}/git-comsu" ]; then
    $SUDO $CREATE_COMMAND "${MYFOLDER}/git-comsu" "${SHARE_DIR}/git-comsu" || error_exit "cannot create git-comsu" $E_GIT_COMSU_CREATION_FAIL
fi

# Set execute permissions for the script
if [ ! -x "${SHARE_DIR}/git-comsu" ]; then
    chmod +x "${SHARE_DIR}/git-comsu" 2>/dev/null || $SUDO chmod +x "${SHARE_DIR}/git-comsu" || error_exit "can not make git-omsu exectuable." $E_PERMISSION_FAIL 
fi

echo
echo "Installation completed. You can now run the 'git-comsu' command. Make sure ${SHARE_DIR} exists in the PATH."

# Detect shell and set the appropriate shell configuration file
MY_SHELL=$(basename "$SHELL")
case "$MY_SHELL" in
    zsh)
        SHELL_CONFIG="${HOME}/.zshrc"
        ;;
    bash)
        SHELL_CONFIG="${HOME}/.bashrc"
        ;;
    fish)
        SHELL_CONFIG="${HOME}/.config/fish/config.fish"
        ;;
    tcsh)
        SHELL_CONFIG="${HOME}/.cshrc"
        ;;
    ksh)
        SHELL_CONFIG="${HOME}/.kshrc"
        ;;
    *)
        SHELL_CONFIG="your shell's initialization file"
        ;;
esac

# Suggest adding the path to the user's environment
echo "Add the following to your shell configuration if not already in your ${SHELL_CONFIG}:"
echo "export PATH=\$PATH:${SHARE_DIR}"
echo "Once added, run 'source ${SHELL_CONFIG}' to apply the changes immediately."
