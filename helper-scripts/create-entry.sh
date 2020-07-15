#!/usr/bin/env bash

echo "Filepath: $1"

# Create date string
DATE=$(date +'%B %d, %Y')


# Set starting and ending hour/period of day
HOUR_START=$(date +'%-H')
HOUR_END=$(($HOUR_START + 8))
PERIOD_START="AM"
PERIOD_END="AM"

# If starting hour is after noon, convert HOUR_START & PERIOD_START to p.m.
if [ $HOUR_START -gt 12 ]
then
    HOUR_START=$((HOUR_START - 12))
    PERIOD_START="PM"
fi

# If end hour is after noon, convert HOUR_END & PERIOD_END to p.m.
if [ $HOUR_END -gt 12 ]
then
    HOUR_END=$((HOUR_END - 12))
    PERIOD_END="PM"
fi


# Set starting minute and compensate for bootup time
MINUTE=$(date +'%-M')
MINUTE_COMPENSATED=$(($MINUTE - 5))

# Round to the nearest 5 minutes
MINUTE_ROUNDED=$((( ($MINUTE_COMPENSATED+2) / 5) * 5 ))
MINUTE_STRING=$MINUTE_ROUNDED

# Add a leading 0 if time is below 10 minutes
if [ $MINUTE_ROUNDED -lt 10 ]
then
    MINUTE_STRING="0$MINUTE_ROUNDED"
fi

# Create start and end time strings
START_TIME="$HOUR_START:$MINUTE_STRING $PERIOD_START"
END_TIME="$HOUR_END:$MINUTE_STRING $PERIOD_END"

# Create entry line string
LINE=$(printf "%-25s | %-10s | %-10s |\n" "$DATE" "$START_TIME" "$END_TIME")

# Insert LINE on the third line of hours log
    # This way, entries are added in reverse chronological order and the most recent days are at the top.
ex -s -c "3i|$LINE" -c x $1e