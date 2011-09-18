SIZE = 20

all_entities = new Fathom.Entities

class Tile extends Fathom.Entity
  constructor : (x, y, size, type) ->
    super

    @type = type

  groups : ->
    if type == 0
      ["tile", "renderable"]
    else
      ["tile", "renderable", "wall"]

  render: (context) ->
    if @type == 0
      context.fillStyle = "#f00"
    else if @type == 1
      context.fillStyle = "#ff0"

    context.fillRect @x, @y, @size, @size

###
class Character extends Fathom.Entity
  constructor : (x, y) ->
    super (x, y, SIZE)

  render: (context) ->
###

for x in [0..10]
  for y in [0..10]
    type = if y == 9 then 1 else 0
    all_entities.add new Tile(x * SIZE, y * SIZE, SIZE, type)

gameLoop = (context) ->
  visible = all_entities.get ["renderable"]

  for item in visible
    item.render context

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
