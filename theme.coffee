command: 'echo "$(./amar-bar.widget/scripts/switcher.py)"'

refreshFrequency: 3500

render: (output) ->
  """
  <div class="themeable">

  </div>
  """

update: (output, domEl) ->
  [active, bg, c1] = output.split ':::'

  #$(".themeable").setProperty("--bg", bg)
  #$(".themeable").setProperty("--c1", c1)
  ###
  $(":root").css('--bg', bg)
  $(":root").css('--c1', c1)

  $("div div").css('color', c1)
  $("div div").css('background-color', bg)

  $(".active").css('color', bg)
  $(".active").css('background-color', c1)
  ###
  

style: """
  left: 200px
  top: 20px
"""
