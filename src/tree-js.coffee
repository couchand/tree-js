# tree for json

_ = require 'underscore'

JsonNode = require './json'
print = require './print'

tree = (object, opts) ->
  options = _.extend {}, opts

  tree = new JsonNode "{}", object
  {directories, files} = print tree, options

  totals = "#{directories} objects and arrays"
  unless options.directoriesOnly
    totals += ", #{files} primitives"
  console.log ""
  console.log totals

module.exports = tree
