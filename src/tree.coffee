# tree

_ = require 'underscore'

scan = require './scan'
print = require './print'

tree = (dir, opts) ->
  scan dir, opts, (err, tree) ->
    return console.error err if err
    print tree

module.exports = tree
