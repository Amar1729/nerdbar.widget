command: 'echo "$(./amar-bar.widget/scripts/playing.sh)"'
refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="np"
    <span></span>
    <span class="icon fa fa-play-circle-o"></span>
  </div>
  """

update: (output, el) ->
    # data = JSON.parse(output)
    # artist = data.recenttracks.track[0].artist["#text"]
    # song = data.recenttracks.track[0].name
    # output = "#{song} - #{artist}"
    $(".np span:first-child", el).text("  #{output}")

style: """
  top: 6px
  left: 25%
  height: 16px
  width: 50%

  text-align: center

  overflow: hidden
  text-overflow: ellipsis
"""
