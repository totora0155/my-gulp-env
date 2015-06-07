fs = require 'fs'
$ = require 'gulp'
argv = require('minimist')(process.argv.slice(2))

tasks = JSON.parse fs.readFileSync('tasks.json', 'utf8')
$.task 'new', ->
  path = argv.p or argv.path
  unless path and typeof path is 'string'
    return console.error '--path (-p) is undefined, or isnt String'
  [type, name] = path.match(/(.+)\/(.+)/)[1..2]
  try
    isExist = fs.openSync "../../#{path}", 'r'
    return console.error 'Already exists path' if isExist
  catch
    $.src ['**', '**/.??*'], {read: false, cwd: "../../template/#{type}"}
    .pipe $.dest path, {cwd: '../..'}
    .on 'end', -> console.info "Created project to #{path}"
