# Define ANSI color codes equivalents in PowerShell
$RED = "`e[31m"
$GRAY = "`e[37m"
$GREEN = "`e[32m"
$ICYAN = "`e[96m"
$YELLOW = "`e[33m"
$IYELLOW = "`e[93m"
$NC = "`e[0m"  # No Color

# Check if the API key environment variable is set
if (-not $env:GOOGLE_AI_STUDIO_API_KEY) {
    Write-Host "${YELLOW}Error: The GOOGLE_AI_STUDIO_API_KEY environment variable is not set.${NC}"
    exit 1
}

# URL of the Google Generative AI API endpoint
$API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$($env:GOOGLE_AI_STUDIO_API_KEY)"

# Function to get the staged changes from Git
function Get-StagedChanges {
    # Get the staged changes using git diff --cached
    $changes = git diff --cached

    # Clean up changes: remove newlines and escape double quotes
    $clean_changes = $changes -replace "`n", " " -replace '"', '\"' -replace "'", "\'"
    
    return $clean_changes
}

# Function to generate commit messages using Google Generative AI
function Generate-CommitMessages {
    param (
        [string]$changes
    )
    $PROMPT_FILE = "C:\git-comsu\prompt"  # Update this path to the location of your prompt file

    # Check if the prompt file exists
    if (-not (Test-Path $PROMPT_FILE)) {
        Write-Host "Error: $PROMPT_FILE file not found!"
        exit 1
    }

    # Load prompt from the file
    $prompt_template = Get-Content -Path $PROMPT_FILE -Raw

    # Combine the prompt with changes
    $prompt = "$prompt_template Changes: $changes"

    # Prepare the JSON payload using the cleaned-up prompt
	$promptTemplate = "$prompt"

	# Create the inner JSON structure
	$parts = @{
		"text" = $promptTemplate
	}

	$contents = @{
		"parts" = @($parts)
	}

	# Create the final JSON payload
	$json_payload = @{
		"contents" = @($contents)
	} | ConvertTo-Json -Depth 4


    # Make a request to the Google Generative AI API using Invoke-RestMethod
    $response = Invoke-RestMethod -Uri $API_URL -Method Post -Body $json_payload -ContentType "application/json"

    # Extract and print the response text
    $suggested_messages = $response.candidates[0].content.parts[0].text -replace '"', "'" -replace '`', '' -replace '- ', ''
    
    return $suggested_messages.Trim()
}

# Function to prompt the user for their choice and commit the changes
function Commit-Message {
    param (
        [string[]]$messages
    )

    # Display the messages with numbered options
    for ($i = 0; $i -lt $messages.Length; $i++) {
        Write-Host "${IYELLOW}$($i+1). $($messages[$i])${NC}"
    }

    # Prompt the user for their choice
    Write-Host
    $choice = Read-Host "Write the message number you want to use (write 'x' to exit)"

    # Check the user's choice
    if ($choice -eq "x") {
        Write-Host "${RED}Exiting without committing.${NC}"
        exit 0
    } elseif ($choice -gt 0 -and $choice -le $messages.Length) {
        $selected_message = $messages[$choice - 1]

        # Capture the output of the git commit command
        $commit_output = git commit -m "$selected_message" 2>&1

        # Print the git output in the desired color
        Write-Host "${GRAY}$commit_output${NC}"
        Write-Host
        Write-Host "${GREEN}Committed successfully.${NC}"
    } else {
        Write-Host "${RED}Invalid choice. Exiting without committing.${NC}"
        exit 0
    }
}

# Main execution
function Main {
    # Get the staged changes
    $changes = Get-StagedChanges

    # If there are no changes, exit the script
    if (-not $changes) {
        Write-Host "${YELLOW}No staged changes found.${NC}"
        Write-Host "${YELLOW}You should first add at least one file to stage.${NC}"
        exit 1
    }

    Write-Host "${ICYAN}Generating the commit messages based on your changes ...${NC}"
    Write-Host

    # Generate commit message suggestions
    $messages = Generate-CommitMessages -changes $changes

    # Convert multiline string of messages into an array
    $messages_array = $messages -split "`n"

    # Ask the user to choose a message and commit it
    Commit-Message -messages $messages_array
}

# Run the main function
Main
