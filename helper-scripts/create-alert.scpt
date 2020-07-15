#!/usr/bin/env osascript

var app = Application.currentApplication()
app.includeStandardAdditions = true
var Calendar = Application('Calendar')

var projectCalendars = Calendar.calendars.whose({name: "Work"})
var projectCalendar = projectCalendars[0]
var events = projectCalendar.events.whose({summary: `End of Day - ${app.currentDate().toDateString()}`})
var event = events[0]

// Add a message alarm
var displayAlarm = Calendar.DisplayAlarm({triggerInterval: -5})
event.displayAlarms.push(displayAlarm)

Calendar.reloadCalendars()

console.log('Alert added:')

Calendar.quit()
