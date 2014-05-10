# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Grid
  currentCellGeneration: null # все клетки двумерного массива
  cellSize: 11
  numberOfRows: 40
  numberOfColumns: 100
  seedProbability: 0.1
  tickLength: 100
  canvas: null
  drawingContext: null
  timeout: 0

  constructor: (@width, @height, @cell) ->
    @cellSize = @cell
    @numberOfColumns = @width/@cellSize
    @numberOfRows = (@height/@cellSize)/(0.6*@width/@height)

    console.log @tickLength

    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()

    @seedWithDeadCellsOnly()
    @drawGrid()
#    @tick()

  emptyField: ->
    @seedWithDeadCellsOnly()
    @drawGrid()

  demo: ->
    @seed()
    @drawGrid()

  startDemo: ->
    @seed()
    @tick()

  play: ->
    @tick()

  randomSeed: ->
    @seed()
    @drawGrid()

  pauseDemo: ->
    clearTimeout(@timeout)

  nextStep: ->
    @evolveCellGeneration()
    @drawGrid()


  setCell: (row, col) ->

    currCell = @currentCellGeneration[row][col]
    if (currCell.isAlive)
      currCell.isAlive = false
    else
      currCell.isAlive = true
    @drawCell(currCell)





  seedWithDeadCellsOnly: ->
    @currentCellGeneration = []

    for row in [0...@numberOfRows]
      @currentCellGeneration[row] = []

      for column in [0...@numberOfColumns]
        seedCell = @createCell row, column, false
        @currentCellGeneration[row][column] = seedCell


  createCell: (row, column, isAlive) ->
    isAlive: isAlive
    row: row
    column: column


  createCanvas: ->
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas


  resizeCanvas: ->
    @canvas.height = @cellSize * @numberOfRows
    @canvas.width = @cellSize * @numberOfColumns


  createDrawingContext: ->
    @drawingContext = @canvas.getContext '2d'


  seed: ->
    @currentCellGeneration = []

    for row in [0...@numberOfRows]
      @currentCellGeneration[row] = []

      for column in [0...@numberOfColumns]
        seedCell = @createSeedCell row, column
        @currentCellGeneration[row][column] = seedCell





  createSeedCell: (row, column) ->
    isAlive: Math.random() < @seedProbability
    row: row
    column: column


  drawGrid: ->
    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
#        @currentCellGeneration[row][column].isAlive = true
        @drawCell @currentCellGeneration[row][column]


  drawCell: (cell) ->
    x = cell.column * @cellSize
    y = cell.row * @cellSize

    if cell.isAlive
      fillStyle = 'rgb(132, 132, 132)'
    else
      fillStyle = 'rgb(252, 252, 252)'

    @drawingContext.strokeStyle = 'rgba(0, 0, 0, 0.2)'
    @drawingContext.strokeRect x, y, @cellSize, @cellSize

    @drawingContext.fillStyle = fillStyle
    @drawingContext.fillRect x, y, @cellSize, @cellSize




  tick:  =>
    @drawGrid()
    @evolveCellGeneration()

    @timeout = setTimeout @tick, @tickLength







  evolveCellGeneration: ->
    newCellGeneration = []

    for row in [0...@numberOfRows]
      newCellGeneration[row] = []

      for column in [0...@numberOfColumns]
        evolvedCell = @evolveCell @currentCellGeneration[row][column]
        newCellGeneration[row][column] = evolvedCell

    @currentCellGeneration = newCellGeneration




  evolveCell: (cell) ->
    evolvedCell =
      row: cell.row
      column: cell.column
      isAlive: cell.isAlive

    numberOfAliveNeighbors = @countAliveNeighbors cell

    if cell.isAlive or numberOfAliveNeighbors is 3
      evolvedCell.isAlive = 1 < numberOfAliveNeighbors < 4

    evolvedCell

# живая: если клетка живая и число соседей 2, 3
# живая: если клетка метрвая но число соседей 3


  countAliveNeighbors: (cell) ->
    lowerRowBound = Math.max cell.row - 1, 0
    upperRowBound = Math.min cell.row + 1, @numberOfRows - 1
    lowerColumnBound = Math.max cell.column - 1, 0
    upperColumnBound = Math.min cell.column + 1, @numberOfColumns - 1
    numberOfAliveNeighbors = 0

    for row in [lowerRowBound..upperRowBound]
      for column in [lowerColumnBound..upperColumnBound]
        continue if row is cell.row and column is cell.column

        if @currentCellGeneration[row][column].isAlive
          numberOfAliveNeighbors++

    numberOfAliveNeighbors


window.Grid = Grid