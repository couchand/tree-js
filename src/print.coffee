# print a tree

#require 'colors'

byName = (a, b) ->
  if a.name < b.name
    -1
  else if a.name > b.name
    1
  else
    0

print = (tree, indent='') ->
  display = if tree.isDirectory()
    tree.name.blue.bold
  else
    tree.name
  console.log indent + display
  spaces = indent.replace /[^│├]/g, ' '
    .replace /├/g, '│'
  contents = tree.contents.sort byName
  for i, child of contents
    continue if child.name[0] is '.'
    joint = if i is "#{contents.length - 1}" then "└" else "├"
    print child, "#{spaces}#{joint}── "

module.exports = print
