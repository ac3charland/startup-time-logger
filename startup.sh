#!/usr/bin/env bash

echo '\n************************************************************************'
echo "Running Startup Script - $(date)"
echo '************************************************************************\n'

# Location for TXT file that records hours
    # Change this if you want to customize the file's name and/or location
LOGFILE=~/Documents/hours-log.txt

# If hours log file doesn't exist, create it.
if [ ! -f "$LOGFILE" ]; then
    echo "Date                      | Start Time | End Time   |\n************************* | ********** | ********** |\n" >> "$LOGFILE"
fi


# Check if startup actions have been run by looking for current date in hours log file:
DATE=$(date +'%B %d, %Y')
if grep -Fq "$DATE" "$LOGFILE"; then
    echo "Startup script already ran today."
else
    # If no entry for today in the hours log file, create one:
    echo 'Creating log for today in hours-log.txt:'
    sh helper-scripts/create-entry.sh $LOGFILE
    echo 'Done.'

    echo '\n************************************************************************\n'

    # Create calendar reminder for EOD
    echo 'Creating calendar event for end of the current workday:'
    osascript -l JavaScript helper-scripts/create-event.scpt

    echo '\n************************************************************************\n'

    # Create alert for calendar reminder
    echo 'Creating alert for EoD calendar event:'
    sleep 2
    osascript -l JavaScript helper-scripts/create-alert.scpt
fi

echo '\n************************************************************************'
echo 'Finishing Startup Script'
echo '************************************************************************\n'
