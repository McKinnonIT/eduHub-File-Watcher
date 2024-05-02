# EduHub File Watcher

## Overview
This PowerShell script provides a monitoring solution for changes to a specific eduHub CSV file within a directory. Alerts use Google Chat webhooks, but can be modified to alert you in a way that suits you.

## Prerequisites
To use this script, you will need:
- PowerShell 5.0 or higher.
- A valid webhook URL to receive notifications.

## Configuration
Before running the script, make necessary modifications to suit your environment:
1. Replace `<eduhub csv file you want to monitor here>` with the name of the CSV file you want to monitor.
2. Update the `$path` variable with the directory path where your CSV file is stored.
3. Set the `$webhookUrl` variable to your actual webhook URL to receive notifications, and adjust the payload to fit the service.
   3a. (Optional) Alternatively, modify the action as you require.

## Usage
To start the file monitoring process, run the script in PowerShell:
```powershell.\EduHubFileWatcher.ps1```

## Scheduled Task Setup
To ensure the script runs automatically at system startup:

1. Set up the script as a scheduled task in the Task Scheduler on your eduSTAR server.
2. Use the trigger "At system startup".
3. Configure the task to "Run whether user is logged on or not".
4. Use a EDU002 service account for running the scheduled task.
This setup ensures that the monitoring starts automatically every time the server boots up, regardless of user sessions.

## How It Works
The script sets up a file system watcher on the specified path and file.
It listens for any 'Changed' events on the file.
Upon detecting a change, it fetches the new content, prepares a notification message including the timestamp and the modified SFKEYs from the CSV, and sends it to the configured webhook URL.
