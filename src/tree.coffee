# tree

scan = require './scan'
print = require './print'

tree = (dir) ->
  scan dir, (err, tree) ->
    return console.error err if err
    print tree

module.exports = tree
