$ ->
  $('.vote-trigger').click ->
    $trigger = $ @
    $icon = $('#vote-ico')
    if $trigger.hasClass 'voted'
      $icon.removeClass('fas fa-star')
      $icon.addClass('far fa-star')
    else
      $icon.removeClass('far fa-star')
      $icon.addClass('fas fa-star')
    $badge = $trigger
      .parents '.actions'
      .siblings '.badge'

    increase = ->
      return unless $badge.length
      $badge.text($badge.text()-0+1)
    decrease = ->
      return unless $badge.length
      $badge.text($badge.text()-1 || '')

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
      if method is 'DELETE'
        $trigger
          .removeClass 'voted'
          .removeAttr 'data-vote'
        decrease()
      else
        $trigger.addClass 'voted'
        if res?.id then $trigger.attr 'data-vote', res.id
        increase()

    .always ->
      $icon
        .removeClass 'fa-spin'
