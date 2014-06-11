# file data structure

class Node
  constructor: (@name, @stats) ->
    @_contents = []

  add: (file) ->
    @_contents.push file

  contents: ->
    if @isSymbolicLink() and @linkTarget
      @linkTarget.contents()
    else
      @_contents

  isDirectory: ->
    @stats.isDirectory()

  isFile: ->
    @stats.isFile()

  isSymbolicLink: ->
    @stats.isSymbolicLink()

  isExecutable: ->
    /[1357]/.test @stats.mode.toString(8)[-3..]

  display: ->
    if @isDirectory()
      @name.blue.bold
    else if @isSymbolicLink()
      "#{@name.cyan.bold} -> #{@linkTarget.display()}"
    else if @isExecutable()
      @name.green.bold
    else
      @name

module.exports = Node
