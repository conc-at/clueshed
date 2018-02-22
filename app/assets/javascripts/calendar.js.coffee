#= require moment
#= require jquery-ui
#= require fullcalendar

expandCal = ($cal, $items) ->
  return if $items.children().length
  $items.parent().hide()
  $cal.parent().addClass('col-md-12').removeClass('col-md-6')

persistCal = ($cal) ->
  localStorage.setItem 'clueshed-calendar', JSON.stringify $cal.data('fullCalendar').clientEvents().map (event) ->
    filtered = {}
    Object.keys(event).forEach (key) ->
      if !/^_/.test(key) and key isnt 'source'
        filtered[key] = event[key]
    filtered

restoreCal = ($cal, $items) ->
  events = (JSON.parse localStorage.getItem 'clueshed-calendar') or []
  $cal.fullCalendar 'addEventSource', events if events.length
  events.forEach (event) ->
    $("#event-#{event.id}").remove()
  expandCal $cal, $items

$ ->
  $items = $ '#items'
  $cal = $ '#calendar'

  expandCal = expandCal.bind null, $cal, $items
  persistCal = persistCal.bind null, $cal, $items
  restoreCal = restoreCal.bind null, $cal, $items

  $.get '/contribs.json'
  .then (res) ->
    $list = $('#items').empty()
    res.sort (contrib) -> -contrib.votes
    res.forEach (contrib) ->
      $list.append(
        $('<div>')
          .draggable(revert: true)
          .data('event',
            title: "#{contrib.title} by #{contrib.user.username}"
            duration: '01:00'
            id: contrib.id
          )
          .addClass('list-group-item')
          .attr('id', "event-#{contrib.id}")
          .text(contrib.title)
        .append(
          $('<small>')
            .text(" by #{contrib.user.username}")
          )
        .append(
          $('<span>')
            .addClass('badge')
            .text(contrib.votes)
          )
        )
    unless res.length
      $list.append('<div>').addClass('list-group-item').text('No Contribs yet.')

    $cal.fullCalendar
      drop: (data, event) ->
        $(event.target).remove()
        expandCal()
        persistCal()
      header: left: '', center: '', right: ''
      height: 800,
      minTime: '07:00:00'
      maxTime: '22:00:00'
      editable: yes
      defaultView: 'agendaDay'
      allDaySlot: no
      defaultDate: '2018-03-03'
      timeFormat: 'HH:mm',
      slotLabelFormat: 'HH:mm'
      dayNames: do -> [0...7].map -> 'Event Day'
      droppable: yes
      eventDrop: persistCal
      eventResize: persistCal
      viewRender: do ->
        firstrender = yes
        ->
          return unless firstrender
          restoreCal()
          firstrender = no
