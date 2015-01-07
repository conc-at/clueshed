#= require moment
#= require jquery-ui
#= require fullcalendar

$ ->
  $items = $ '#items'
  $cal = $ '#calendar'

  $.get '/contribs.json'
  .then (res) ->
    $list = $('#items').empty()
    res.sort (contrib) -> -contrib.votes
    res.forEach (contrib) ->
      $list.append(
        $('<div>')
          .draggable(revert: true)
          .data('event', title: contrib.title + ' by ' + contrib.user.username, duration: '00:30')
          .addClass('list-group-item')
          .text(contrib.title)
        .append(
          $('<small>')
            .text(' by ' + contrib.user.username)
          )
        .append(
          $('<span>')
            .addClass('badge')
            .text(contrib.votes)
          )
        )

  $cal.fullCalendar
    drop: (data, event) ->
      $(event.target).remove()
      unless $items.children().length
        $items.parent().hide()
        $cal.parent().addClass('col-md-12').removeClass('col-md-6')
    header: left: '', center: '', right: ''
    minTime: '08:00:00'
    maxTime: '19:00:00'
    editable: yes
    defaultView: 'agendaDay'
    allDaySlot: no
    defaultDate: '2015-07-03'
    dayNames: do -> [0...7].map -> 'Event Day'
    businessHours:
      start: '09:00'
      end: '18:00'
    droppable: yes
