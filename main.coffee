SIZE = 20

all_entities = new Fathom.Entities

class Tile extends Fathom.Entity
  constructor : (x, y, size, type) ->
    super

    @type = type

  groups : ->
    if @type == 0
      ["tile", "renderable"]
    else
      ["tile", "renderable", "wall"]

  render: (context) ->
    if @type == 0
      context.fillStyle = "#f00"
    else if @type == 1
      context.fillStyle = "#ff0"

    context.fillRect @x, @y, @size, @size

class Map extends Fathom.Entity
  constructor : (x, y, tileClass = null) ->
    addTile = (x, y) ->
      type = if y == 8 then 1 else 0
      tile = new tileClass(x * SIZE, y * SIZE, SIZE, type)
      all_entities.add tile
      tile
    @tiles = ((addTile(a, b) for b in [0...y]) for a in [0...x])

  render : (context) ->

class Character extends Fathom.Entity
  constructor : (x, y) ->
    super x, y, SIZE

    @vx = @vy = 0

    @on "pre-update", Fathom.BasicControls.RPGLike 5, this
    @on "post-update", -> @vx = @vy = 0

  groups : ->
    ["renderable", "updateable"]

  render: (context) ->
    context.fillStyle = "#0f0"
    context.fillRect @x, @y, @size, @size

  update: (entities) ->
    @x += @vx
    @x -= @vx if entities.any ["wall", ((other) => @touchingEntity other)]

    @y += @vy
    @y -= @vy if entities.any ["wall", ((other) => @touchingEntity other)]

  depth : -> 1

class Text extends Fathom.Entity
  constructor : (@text, x=0, y=0, opts={}) ->
    super x, y
    @font     = opts.font     || "16px Courier New"
    @color    = opts.color    || "#000000"
    @baseline = opts.baseline || "top"
  groups : -> ["renderable"]
  render : (context) ->
    context.fillStyle    = @color
    context.font         = @font
    context.textBaseline = @baseline
    context.fillText @text, @x, @y
  depth : -> 2

all_entities.add new Character(50, 50)
all_entities.add new Text("Hello world!", 50, 0)

map = new Map(10, 10, Tile)

gameLoop = (context) ->
  all_entities.update all_entities
  all_entities.render context

Fathom.initialize gameLoop
