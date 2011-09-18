all_entities = new Entities

ent = "entity" : "yep"
all_entities.add ent, ["stuffs"]
console.log ent
console.log(all_entities.get ["stuffs"])
all_entities.removeEntity ent
console.log(all_entities.get ["stuffs"])

gameLoop = () ->
  console.log "Sup"

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

  fixedInterval gameLoop, 20


# MOVETO FATHOM
whenReady () -> initialize(500)
