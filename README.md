# Startup Time Logger

This is a set of scripts to help automate tracking your hours. When your machine boots up, it will record the time you logged on and create an alert 8 hours later to remind you to wrap up for the day. No more checking the clock. No more messing with Excel spreadsheets. This takes care of all that for you.

## The Basic Elements
The main script you want to run when your machine boots up is `startup.sh` (see **How to Run on Startup** below). This file will:
- Create a txt file to record your start and end times if it doesn't exist already. The path to this txt file is set by `$LOGFILE`. If you want to customize the name or path to your record document, update this variable.
- Add a new record to this file of your start and end times for the day. This is done with `helper-scripts/create-entry.sh`
- Create an iCal event 8 hours after your start time to mark the end of the day. This is done with `helper-scripts/create-event.scpt`
- Add an alert to this event for 5 minutes before the end of the day. This is done with `helper-scripts/create-alert.scpt`

## How to Run on Startup
There are different ways to do this, but what worked for me was:

1. Create an Automator program to execute your shell script.
    1. Create a new Automator application.
    2. Add the action "Run Shell Script"
    3. To that action, execute `startup.sh` using your local path, e.g.
        - `sh ~/local/path/to/this/repo/startup-time-logger/startup.sh`
2. Once your Automator program is created, open system preferences and select "Users & Groups" > "Login Items"
3. Add your Automator application to this list. All the programs in it will execute on startup.
    
Since this script has access to your Calendar application, MacOS wants you to grant permission before it allows the script access. I found that this solution handled security permissions more gracefully than more advanced, Linux-y solutions, since you can just grant Automator access to your calendar using the system dialog.
