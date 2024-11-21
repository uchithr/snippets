#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Exiting." 
   exit 1
fi

# Get username as input
read -p "Enter the username to create a mobile account for: " username

# Verify the user exists in the network directory
if ! dscl . -list /Users | grep -q "$username"; then
  echo "Error: Username $username does not exist in the directory. Exiting."
  exit 1
fi

# Log the action
logfile="/var/log/mobile_account_creation.log"
echo "$(date): Attempting to create mobile account for $username" >> $logfile

# Create the mobile account
sudo /System/Library/CoreServices/ManagedClient.app/Contents/Resources/createmobileaccount -n "$username"

# Verify success
if [[ $? -eq 0 ]]; then
  echo "$(date): Mobile account for $username created successfully." >> $logfile
else
  echo "$(date): Failed to create mobile account for $username." >> $logfile
  exit 1
fi

echo "Mobile account created successfully for $username."
