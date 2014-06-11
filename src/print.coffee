# print a tree

require 'colors'

byName = (a, b) ->
  if a.name < b.name
    -1
  else if a.name > b.name
    1
  else
    0

print = (tree, options, indent='') ->
  exclude = options.exclude? and new RegExp options.exclude
  display = tree.display()
  console.log indent + display
  spaces = indent.replace /[^│├]/g, ' '
    .replace /├/g, '│'
  contents = tree.contents()
    .sort byName
    .filter (child) ->
      child.isFile() or child.isDirectory() or child.isSymbolicLink()
    .filter (child) ->
      (child.name[0] isnt '.' or options.allFiles) and
        not (exclude and exclude.test child.name)

  directories = files = 0
  for child in contents
    if child.isDirectory() or child.isSymbolicLink() and child.linkTarget.isDirectory()
      directories += 1
    else
      files += 1

  if options.directoriesOnly
    contents = contents.filter (child) ->
      child.isDirectory() or child.isSymbolicLink() and child.linkTarget.isDirectory()
  if tree.isSymbolicLink()
    return unless options.followLinks
  for i, child of contents
    joint = if i is "#{contents.length - 1}" then "└" else "├"
    children = print child, options, "#{spaces}#{joint}── "
    directories += children?.directories or 0
    files += children?.files or 0

  {directories, files}

module.exports = print
