fs = require 'fs'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')

tasks = JSON.parse fs.readFileSync('./tasks.json', 'utf8')
$.task 'default', -> $.watch src, [task] for task, src of tasks
