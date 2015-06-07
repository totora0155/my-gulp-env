fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')
series = require 'stream-series'
browserSync = require('browser-sync').create()

tasks = JSON.parse fs.readFileSync './tasks.json', 'utf8'
cssStream = $.src ['style/**/*.css'], {read: false}
jsStream = $.src ['script/lib/**/*.js', 'script/**/*.js'], {read: false}

$.task 'html', ->
  $.src tasks.html
  .pipe $p.template JSON.parse fs.readFileSync './config.json', 'utf8'
  .pipe $p.inject(
    series(cssStream, jsStream)
    relative: true
  )
  .pipe $.dest '.'
  .pipe browserSync.stream()
