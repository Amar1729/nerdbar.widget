commands =
  space: 'echo "$(./amar-bar.widget/scripts/spaces.sh)"'
  focus: 'echo "$(./amar-bar.widget/scripts/switcher.sh 2>/dev/null)"'

command: "echo " +
  "$(#{ commands.space }):::" +
  "$(#{ commands.focus })"

# original (singular) command:
#command: 'echo "$(./amar-bar.widget/scripts/spaces.sh)"'

refreshFrequency: 1000 # ms

render: ( ) ->
  """
  <div class="foc"
    <span></span>
    <span class="icon fa fa-bars"></span>
  </div>
  """

# construct entire top-left: mode, list of spaces, focused window name
update: (output, el) ->
  # get the updated colors on space switch
  [output, _, bg, c1] = output.split ':::'
  new_style = @construct_style bg, c1

  # get monospaced spaces list:
  [mode, spaces, focused...] = output.split '|'
  spaces = (@format_active space, new_style for space in (spaces.split ' ')).join('')
  focused = @trunc_focused focused.join('|'), 60
  rendered = ["<span>#{mode}</span>", spaces, "<span class=\"focused\">#{focused}</span>"].join('|')
  $(".foc span:first-child", el).html("  #{rendered}")

# truncates focused window title if too long
trunc_focused: (str, limit) ->
  return if (str.length < limit) then str else (str.substring(0,limit) + "...")

# checks if this number is the active space (will be surrounded by parens)
# adds class 'active' or 'inactive' and returns HTML
format_active: (elem, active_style) ->
  elem.replace /^\s+|\s+$/g, ""
  if elem is ""
    return """ """
  else
    if elem[0] is "("
      elem = elem[1...-1]
      elem = """<span class="list active" #{active_style}>#{elem}</span>"""
    else
      elem = """<span class="list inactive">#{elem}</span>"""
    return elem

# NOTE - Most theme resetting is done in theme.coffee
# create style attrs for the active space specifically
construct_style: (bg, c1) ->
  """
  style="
    /*color: #ffffff;*/
    color: #{bg};
    background-color: #{c1}"
  """

style: """
  left: 10px
"""
