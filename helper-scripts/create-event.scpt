#!/usr/bin/env osascript

var app = Application.currentApplication()
app.includeStandardAdditions = true
var Calendar = Application('Calendar')

var eventStart = app.currentDate()
eventStart = eventStart
eventStart.setDate(eventStart.getDate())
eventStart.setHours(eventStart.getHours() + 8)
eventStart.setMinutes((Math.round(eventStart.getMinutes()/5)*5)-5)
eventStart.setSeconds(0)
var eventEnd = new Date(eventStart.getTime())
eventEnd.setMinutes(eventStart.getMinutes() + 10)

var workCalendars = Calendar.calendars.whose({name: 'Work'})
var workCalendar = workCalendars[0]
var displayAlarm = Calendar.DisplayAlarm({triggerInterval: -5})
var summary = `End of Day - ${eventStart.toDateString()}`
var event = Calendar.Event({summary: summary, startDate: eventStart, endDate: eventEnd})
workCalendar.events.push(event)

console.log('Event created:')

Calendar.quit()
