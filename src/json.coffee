# json data structure

_ = require 'underscore'

class JsonNode
  constructor: (@name, @value) ->

  contents: ->
    unless @isDirectory()
      []
    else
      _.pairs @value
        .map ([k, v]) -> new JsonNode k, v

  isDirectory: ->
    _.any [
      _.all [
        _.isObject @value
        not _.isFunction @value
      ]
      _.isArray @value
    ]

  isFile: ->
    _.any [
      _.isNull @value
      _.isString @value
      _.isNumber @value
      _.isBoolean @value
    ]

  isSymbolicLink: -> no

  display: ->
    if @isDirectory()
      @name.blue.bold
    else if @isFile()
      "#{@name.cyan.bold}: #{JSON.stringify @value}"

module.exports = JsonNode
