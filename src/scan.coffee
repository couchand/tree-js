# scan directory tree, calling back with root node

fs = require 'fs'
path = require 'path'

Node = require './node'

shouldScan = (name) ->
  name[0] isnt '.' or name is '.' or name is '..'

scanDir = (within, dir, cb) ->
  dirpath = path.join within, dir.name
  fs.readdir dirpath, (err, contents) ->
    left = contents.length
    check = (err, file) ->
      if err
        left = -1
        cb err
      else
        dir.contents.push file
        left = left - 1
        cb null, dir if 0 is left

    contents.forEach (filename) ->
      scanFile dirpath, filename, check

scanFile = (within, filename, cb) ->
  filepath = path.join within, filename
  fs.stat filepath, (err, stats) ->
    return cb err if err
    unless stats.isDirectory() and shouldScan filename
      cb null, new Node filename, stats
    else
      dir = new Node filename, stats
      scanDir within, dir, cb

scan = (dirname, cb) ->
  scanFile '.', dirname, cb

module.exports = scan
