command: 'echo "$(./amar-bar.widget/scripts/switcher.sh 2>/dev/null)"'

refreshFrequency: 1000

render: ( ) ->
  """
  <div class="">

  </div>
  """

update: (output, domEl) ->
  [active, bg, c1] = output.split ':::'

  $("div div").css('color', c1)
  $("div div").css('background-color', bg)

  # resetting this here leads to an odd race condition with
  # focused-window.coffee (the active box blinks between two colors).
  # do the .active css resetting there instead.
  #$(".active").css('color', bg)
  #$(".active").css('background-color', c1)

style: """
  left: 200px
  top: 20px
"""
