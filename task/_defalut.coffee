fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')
browserSync = require('browser-sync').create 'gulp'
argv = require('minimist')(process.argv.slice(2))

tasks = JSON.parse fs.readFileSync('./tasks.json', 'utf8')
$.task 'default', ->
  opts =
    notify: false
    open: false
    port: 8000
    server: false
    proxy: false
  if /\./.test argv.server
    opts.proxy = argv.server
  else
    opts.server = if argv.server? then argv.server else 'app'

  browserSync.init opts
  $.watch src, [task] for task, src of tasks
    # if /^(?:coffee)$/.test task then $.watch src, [task]
    # else $.watch src, [task]
