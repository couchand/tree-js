# tree data structure

class Node
  constructor: (@name, @stats) ->
    @contents = []

  isDirectory: ->
    @stats.isDirectory()

  isFile: ->
    @stats.isFile()

  display: ->
    if @isDirectory()
      @name.blue.bold
    else
      @name

module.exports = Node
