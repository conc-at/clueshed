#= require moment
#= require jquery-ui
#= require fullcalendar

$ ->
  $schedule = $ '#schedule'

  $schedule.fullCalendar({
    height: 800,
    defaultView: 'agendaDay'
    events: '/schedule.json'
    header: { left: '', center: '', right: '' }
    minTime: '08:00:00'
    maxTime: '24:00:00'
    allDaySlot: no
    defaultDate: '2018-03-03'
    timeFormat: 'HH:mm',
    slotLabelFormat: 'HH:mm'
  })
