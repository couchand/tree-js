# tree data structure

class Node
  constructor: (@name, @stats) ->
    @contents = []

  isDirectory: ->
    @stats.isDirectory()

  isFile: ->
    @stats.isFile()

  isExecutable: ->
    /[1357]/.test @stats.mode.toString(8)[-3..]

  display: ->
    if @isDirectory()
      @name.blue.bold
    else if @isExecutable()
      @name.green.bold
    else
      @name

module.exports = Node
