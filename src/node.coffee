# tree data structure

class Node
  constructor: (@name, @stats) ->
    @contents = []

  isDirectory: ->
    @stats.isDirectory()

  isFile: ->
    @stats.isFile()

module.exports = Node
