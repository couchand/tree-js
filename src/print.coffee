# print a tree

#require 'colors'

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
  contents = tree.contents
    .sort byName
    .filter (child) ->
      child.name[0] isnt '.' and
        not (exclude and exclude.test child.name)
  if options.directoriesOnly
    contents = contents.filter (child) -> child.isDirectory()
  for i, child of contents
    joint = if i is "#{contents.length - 1}" then "└" else "├"
    print child, options, "#{spaces}#{joint}── "

module.exports = print
