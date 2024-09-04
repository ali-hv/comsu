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
Write-Host "Installation completed. You can now run 'git-comsu' command."
Write-Host "Note: You may need to restart your terminal or run 'refreshenv' for the changes to take effect."
