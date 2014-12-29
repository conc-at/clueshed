$ ->
  expand = (action) ->->
    $(@)[action] 'expanded'

  $ '#new_contrib, #new_interest'
  .on 'focusin', expand 'addClass'
  .on 'focusout', expand 'removeClass'
