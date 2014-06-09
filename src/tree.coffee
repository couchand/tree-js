# tree

_ = require 'underscore'

scan = require './scan'
print = require './print'

tree = (dir, opts) ->
  scan dir, opts, (err, tree) ->
    return console.error err if err
    {directories, files} = print tree, opts

    totals = "#{directories} directories"
    unless opts.directoriesOnly
      totals += ", #{files} files"
    console.log ""
    console.log totals

module.exports = tree
