# Function to copy folders with progress
function Copy-Folder {
    param (
        [string]$sourcePath,
        [string]$destinationPath,
        [string[]]$folders
    )

    foreach ($folder in $folders) {
        $sourceFolder = Join-Path -Path $sourcePath -ChildPath $folder
        $destinationFolder = Join-Path -Path $destinationPath -ChildPath $folder

        # Create destination folder if it doesn't exist
        if (-not (Test-Path $destinationFolder)) {
            New-Item -Path $destinationFolder -ItemType Directory | Out-Null
        }

        if (Test-Path $sourceFolder) {
            Write-Host "Copying $folder from $sourceFolder to $destinationFolder..."
            Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force -Verbose
        } else {
            Write-Host "$folder does not exist in the source path: $sourceFolder"
        }
    }
    Write-Host "Copy operation completed."
}

# Get user input for copy type (Network or Local)
$copyType = Read-Host "Do you want to copy from a Network or Local source? Type 'Network' or 'Local'"

# Get user profile path for the local copy
$userProfile = [System.Environment]::GetFolderPath('UserProfile')

# Define the folders to copy
$foldersToCopy = @("Desktop", "Documents", "Downloads", "Pictures")

# Based on user input, prompt for the source path and perform the copy operation
switch ($copyType) {
    "Network" {
        $networkSource = Read-Host "Please enter the network source path (e.g., \\bob\c$\users\sam)"
        $localDestination = $userProfile
        Write-Host "Starting network copy..."
        Copy-Folder -sourcePath $networkSource -destinationPath $localDestination -folders $foldersToCopy
    }

    "Local" {
        $localSource = Read-Host "Please enter the local source path (e.g., C:\Users\Sam)"
        $destinationPath = Read-Host "Please enter the destination folder path"
        Write-Host "Starting local copy..."
        Copy-Folder -sourcePath $localSource -destinationPath $destinationPath -folders $foldersToCopy
    }

    default {
        Write-Host "Invalid option. Please type 'Network' or 'Local'."
    }
}

pause