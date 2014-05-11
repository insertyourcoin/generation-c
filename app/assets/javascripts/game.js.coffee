# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Game
  currentCellGeneration: null
  previousCellGeneration: null
  cellSize: null
  numberOfRows: null
  numberOfColumns: null
  seedProbability: 0.5
  tickLength: 500
  canvas: null
  drawingContext: null

  constructor: (@width, @height, @cell, turn_on_rule, turn_off_rule) ->
    @cellSize = @cell
    @numberOfColumns = @width/@cellSize
    @numberOfRows = (@height/@cellSize)/(0.6*@width/@height)
    @turn_on_rule = turn_on_rule.toString()
    @turn_off_rule = turn_off_rule.toString()

    @initializeArrays()
    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()
    @seedWithDeadCellsOnly()
    @drawBorders()
#    @drawGrid()

#    @tick()

  getCurrentCellGeneration: ->
    @currentCellGeneration

  getAliveCells: ->
    @aliveCells = []

    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
        if @currentCellGeneration[row][column].isAlive
          @aliveCells.push @currentCellGeneration[row][column]

    @aliveCells


  setGrid:(json) ->
    i = 0
    a = @currentCellGeneration
    b = @previousCellGeneration
    $.each json, (key, value) ->
      a[value.y][value.x].isAlive = true
      b[value.y][value.x].isAlive = false
      i++
    @drawGrid()


  increaseCells: ->
    #clearTimeout(@timeout)
    @cellSize = @cellSize * 2
    @numberOfColumns = @numberOfColumns / 2
    @numberOfRows = @numberOfRows / 2
    @drawBorders()
    #@tick()

  decreaseCells: ->
    #clearTimeout(@timeout)
    @cellSize = @cellSize / 2
    @numberOfColumns = @numberOfColumns * 2
    @numberOfRows = @numberOfRows * 2
    @drawBorders()
    #@tick()

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



  initializeArrays: ->
    @currentCellGeneration = []
    @previousCellGeneration = []
    for row in [0..999]
      @currentCellGeneration[row] = []
      @previousCellGeneration[row] = []
      for column in [0..999]
        seedCell = @createCell row, column, false
        seedInv = @createCell row, column, true
        @currentCellGeneration[row][column] = seedCell
        @previousCellGeneration[row][column] = seedInv
    alert(1000)



  seedWithDeadCellsOnly: ->
    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
        seedCell = @createCell row, column, false
        seedInv = @createCell row, column, true
        @currentCellGeneration[row][column] = seedCell
        @previousCellGeneration[row][column] = seedInv

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
    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
        seedCell = @createSeedCell row, column
        @currentCellGeneration[row][column] = seedCell
        @previousCellGeneration[row][column] = @currentCellGeneration[row][column]
        @previousCellGeneration[row][column].isAlive = !@previousCellGeneration[row][column].isAlive




  createSeedCell: (row, column) ->
    isAlive: Math.random() < @seedProbability
    row: row
    column: column


  drawGrid: ->
    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
        if(@currentCellGeneration[row][column] != @previousCellGeneration[row][column])
          @drawCell @currentCellGeneration[row][column]

  drawBorders: ->
    for row in [0...@numberOfRows]
      for column in [0...@numberOfColumns]
        @drawBorderedCell @currentCellGeneration[row][column]


  drawBorderedCell: (cell) ->
    x = cell.column * @cellSize
    y = cell.row * @cellSize

    if cell.isAlive
      fillStyle = 'rgb(132, 132, 132)'
    else
      fillStyle = 'rgb(252, 252, 252)'

    @drawingContext.strokeStyle = 'rgba(0, 0, 0, 1)'
    @drawingContext.strokeRect x, y, @cellSize, @cellSize

    @drawingContext.fillStyle = fillStyle
    @drawingContext.fillRect x+1, y+1, @cellSize-1, @cellSize-1

  drawCell: (cell) ->
    x = cell.column * @cellSize
    y = cell.row * @cellSize

    if cell.isAlive
      fillStyle = 'rgb(132, 132, 132)'
    else
      fillStyle = 'rgb(252, 252, 252)'

#    @drawingContext.strokeStyle = 'rgba(0, 0, 0, 1)'
#    @drawingContext.strokeRect x, y, @cellSize, @cellSize

    @drawingContext.fillStyle = fillStyle
    @drawingContext.fillRect x+1, y+1, @cellSize-1, @cellSize-1




  tick: =>
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
    @previousCellGeneration = @currentCellGeneration
    @currentCellGeneration = newCellGeneration




  evolveCell: (cell) ->
    evolvedCell =
      row: cell.row
      column: cell.column
      isAlive: cell.isAlive

    numberOfAliveNeighbors = @countAliveNeighbors cell
    if cell.isAlive == true
      if @turn_off_rule[numberOfAliveNeighbors] == '1'
        evolvedCell.isAlive = false
    else
      if @turn_on_rule[numberOfAliveNeighbors] == '1'
        evolvedCell.isAlive = true

    #    if cell.isAlive or numberOfAliveNeighbors is 3
    #      evolvedCell.isAlive = 1 < numberOfAliveNeighbors < 4

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


window.Game = Game