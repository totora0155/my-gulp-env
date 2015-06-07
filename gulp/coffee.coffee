fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')

tasks = JSON.parse fs.readFileSync './tasks.json', 'utf8'
if tasks.coffee? then $.task 'coffee', ->
  $.src tasks.coffee
  .pipe $p.plumber()
  .pipe $p.cached 'Cache Coffee'
  .pipe $p.sourcemaps.init()
  .pipe $p.coffeelint()
  .pipe $p.coffeelint.reporter()
  .pipe $p.coffee {bare: true}
  .pipe $p.sourcemaps.write './'
  .pipe $p.size {showFiles: true, title: 'JS'}
  .pipe $.dest 'app/script'
