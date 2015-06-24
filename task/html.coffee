fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')
merge = require 'merge-stream'
browserSync = require('browser-sync').get 'gulp'

tasks = JSON.parse fs.readFileSync './tasks.json', 'utf8'
if tasks.html? then $.task 'html', ->
  cssStream = $.src ['app/style/**/*.css'], {read: false}
  jsStream = $.src ['app/script/lib/**/*.js', 'app/script/**/*.js'], {read: false}

  $.src tasks.html
  .pipe $p.template JSON.parse fs.readFileSync './config.json', 'utf8'
  .pipe $p.inject(
    merge cssStream, jsStream
    {
      relative: true
      ignorePath: '..'
    }
  )
  .pipe $.dest 'app'
  .pipe browserSync.stream()
