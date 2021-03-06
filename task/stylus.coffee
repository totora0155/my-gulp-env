fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')
browserSync = require('browser-sync').get 'gulp'
axis = require 'axis'
rupture = require 'rupture'
jeet = require 'jeet'

tasks = JSON.parse fs.readFileSync('./tasks.json', 'utf8')
if tasks.stylus? then $.task 'stylus', ->
  $.src tasks.stylus
  .pipe $p.plumber {errorHandler: $p.notify.onError '<%= error.message %>'}
  .pipe $p.cached 'Cached *.styl'
  .pipe $p.sourcemaps.init()
  .pipe $p.stylus
    use: [axis(), rupture(), jeet()]
    include: 'stylus'
    sourcemap: {sourceRoot: '.'}
  .pipe $p.sourcemaps.write '.'
  .pipe $p.size {showFile: true, title: '.styl'}
  .pipe $.dest 'app/style'
  .pipe browserSync.stream()
