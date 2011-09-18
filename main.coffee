all_entities = new Fathom.Entities

class Tile extends Fathom.Entity
  constructor : (x, y, size, type) ->
    super

    @type = type

  render: (context) ->
    if @type == 0
      context.fillStyle = "#f00"
    else if @type == 1
      context.fillStyle = "#ff0"

    context.fillRect @x, @y, @size, @size

SIZE = 20

for x in [0..10]
  for y in [0..10]
    type = if y == 9 then 1 else 0
    console.log type
    all_entities.add new Tile(x * SIZE, y * SIZE, SIZE, type), ["tile"]

gameLoop = (context) ->
  tiles = (all_entities.get ["tile"])

  for tile in tiles
    tile.render(context)

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
