command: "date +\"%H:%M:%S\""

refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="time"
    <span></span>
    <span class="icon fa fa-clock-o"></span>
  </div>
  """

update: (output, el) ->
  $(".time span:first-child", el).text("  #{output}")

style: """
  top: 6px
  right: 10px
"""
