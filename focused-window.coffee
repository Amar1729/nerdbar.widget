command: 'echo "$(./amar-bar.widget/scripts/spaces.sh)"'

refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="foc"
    <span></span>
    <span class="icon fa fa-bars"></span>
  </div>
  """

update: (output, el) ->
  # my attempts to get monospaced spaces list:
  [mode, spaces, focused...] = output.split '|'
  spaces = (@decide_active space for space in (spaces.split ' ')).join('')
  focused = @trunc_focused focused.join('|'), 60
  #output = [ "<span>#{mode}</span>", "|", spaces, "|", "<span class=\"focused overflow\">#{focused}</span>" ].join('')
  output = ["<span>#{mode}</span>", spaces, "<span class=\"focused\">#{focused}</span>"].join('|')
  $(".foc span:first-child", el).html("  #{output}")

# truncates focused window title if too long
trunc_focused: (str, limit) ->
  return if (str.length < limit) then str else (str.substring(0,limit) + "...")

# checks if this number is the active space (will be surrounded by parens)
# adds class 'active' or 'inactive' and returns HTML
decide_active: (elem) ->
  elem.replace /^\s+|\s+$/g, ""
  if elem is ""
    return """ """
  else
    if elem[0] is "("
      elem = elem[1...-1]
      elem = """<span class="list active">#{elem}</span>"""
    else
      elem = """<span class="list inactive">#{elem}</span>"""
    return elem

style: """
  left: 10px
"""
