# scan directory tree, calling back with root node

fs = require 'fs'
path = require 'path'
_ = require 'underscore'

Node = require './node'

shouldScan = (name, options) ->
  (name[0] isnt '.' or name is '.' or name is '..' or options.allFiles) and
    (not options.exclude? or not new RegExp(options.exclude).test name) and
    (not options.depth? or options.depth > 0)

scanDir = (within, dir, options, cb) ->
  dirpath = path.join within, dir.name
  depth = options.depth - 1 if options.depth
  options = _.extend {}, options, {depth}
  fs.readdir dirpath, (err, contents) ->
    if 0 is left = contents.length
      cb null, dir
    check = (err, file) ->
      if err
        left = -1
        cb err
      else
        dir.contents.push file
        left = left - 1
        cb null, dir if 0 is left

    contents.forEach (filename) ->
      scanFile dirpath, filename, options, check

scanFile = (within, filename, options, cb) ->
  filepath = path.join within, filename
  fs.lstat filepath, (err, stats) ->
    return cb err if err
    unless stats.isDirectory() and shouldScan filename, options
      if stats.isSymbolicLink()
        fs.readlink filepath, (err, link) ->
          node = new Node filename, stats
          scanFile within, link, options, (err, target) ->
            return cb err if err
            node.linkTarget = target
            cb null, node
      else
        cb null, new Node filename, stats
    else
      dir = new Node filename, stats
      scanDir within, dir, options, cb

scan = (dirname, options, cb) ->
  scanFile '.', dirname, options, cb

module.exports = scan
