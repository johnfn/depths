all_entities = new Entities

gameLoop = (context) ->
  context.strokeStyle = "black"
  context.fillRect 20, 20, 16, 16

# MOVETO FATHOM
whenReady = (callback) ->
  """A weak approximation of onReady from jQuery. All we care about to start up
  Fathom is that document.body exists, which may not immediately be true."""
  if document.body then callback() else setTimeout (() -> whenReady callback), 250

# MOVETO FATHOM
fixedInterval = (fn, fps) ->
  """This implementation is not complete."""
  setInterval fn, 1000/fps

# MOVETO FATHOM
initialize = (size) ->
  canv = document.createElement "canvas"
  canv.width = canv.height = size
  document.body.appendChild(canv)

  context = canv.getContext('2d')

  fixedInterval (() -> (gameLoop context)), 20


# MOVETO FATHOM
whenReady () -> initialize(500)
