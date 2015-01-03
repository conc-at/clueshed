$ ->
  $('.vote-trigger').click ->
    $trigger = $ @
    $icon = $trigger.find '.fa'

    if $trigger.hasClass 'voted'
      method = 'DELETE'
      url = '/votes/' + $trigger.attr('data-vote') + '.json'
      body = {}
    else
      method = 'POST'
      url = '/votes.json'
      body =
        user_id: $trigger.attr('data-user')

      body[$trigger.attr('data-partip-type')  + '_id'] = $trigger.attr('data-partip-id')


    $icon
      .addClass 'fa-spin'

    $.ajax
      url: url
      type: method
      data: JSON.stringify body
      contentType:'application/json; charset=utf-8'
      dataType:'json'
    .done (res) ->
      $trigger[if method  is 'DELETE' then 'removeClass' else 'addClass'] 'voted'
      $trigger.removeAttr 'data-vote'
      if res?.id then $trigger.attr 'data-vote', res.id
    .always ->
      $icon
        .removeClass 'fa-spin'
