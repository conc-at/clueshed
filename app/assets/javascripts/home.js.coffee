$ ->

  $forms = $ '#new_contrib, #new_interest'
  .on 'focusin', ->
    $ @
    .addClass 'expanded'
  .click (e) ->
    e.stopPropagation()

  $('html').click ->
    $forms.removeClass 'expanded'
