# Check if jq is installed; if not, install it
if (-not (Get-Command jq -ErrorAction SilentlyContinue)) {
    Write-Host "jq not found, installing..."
    # Note: Windows doesn't have a built-in package manager like apt-get
    # You might want to use Chocolatey or another package manager for Windows
    # For this example, we'll just provide a download link
    Write-Host "Please download and install jq from: https://stedolan.github.io/jq/download/"
    Write-Host "After installing, make sure to add it to your PATH."
    Pause
}
else {
    Write-Host "jq is already installed."
}

# Create a directory for shared files
$SHARE_DIR = "C:\git-comsu"
if (-not (Test-Path $SHARE_DIR)) {
    Write-Host "Creating directory for shared files at $SHARE_DIR..."
    New-Item -Path $SHARE_DIR -ItemType Directory -Force | Out-Null
}

# Copy prompt to the shared directory
Write-Host "Copying prompt file to $SHARE_DIR..."
Copy-Item -Path "prompt" -Destination "$SHARE_DIR\" -Force

# Copy git-comsu to a directory in PATH and make it executable
$BIN_DIR = "C:\Windows\System32"
Write-Host "Installing git-comsu script to $BIN_DIR..."
Copy-Item -Path "git-comsu.ps1" -Destination "$BIN_DIR\git-comsu.ps1" -Force

# Add an entry point batch file for easier execution
$BATCH_CONTENT = "@echo off`npowershell.exe -ExecutionPolicy Bypass -File `"%~dp0git-comsu.ps1`" %*"
Set-Content -Path "$BIN_DIR\git-comsu.bat" -Value $BATCH_CONTENT

Write-Host ""
Write-Host "Installation completed. You can now run 'git comsu' command."
Write-Host "Note: You may need to restart your terminal or run 'refreshenv' for the changes to take effect."