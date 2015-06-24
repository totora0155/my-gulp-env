_ = require 'lodash'
$ = require 'gulp'
$p = require('gulp-load-plugins')(config: '../../package.json')
inquirer = require 'inquirer'
libPath =
  style: require '../config/path/stylelib'
  script: require '../config/path/scriptlib'

questions =
  stylelib:
    type: 'checkbox'
    name: 'style'
    ext: 'css'
    message: 'Select libraries'
    choices: Object.keys libPath.style
  scriptlib:
    type: 'checkbox'
    name: 'script'
    ext: 'js'
    message: 'Select libraries'
    choices: Object.keys libPath.script
  styleFilename:
    type: 'input'
    name: 'file'
    message: 'Input filename (default: lib.css)'
    default: 'lib.css'
  scriptFilename:
    type: 'input'
    name: 'file'
    message: 'Input filename (default: lib.js)'
    default: 'lib.js'

selectLib = (questions, done) ->
    inquirer.prompt questions, (answer) ->
      src = _.map answer[questions[0].name], (libAlias) ->
        "../../bower_components/#{libPath[questions[0].name][libAlias]}"
      $.src src
      .pipe $p.concat answer.file
      .pipe $p.if questions[0].ext is 'css',
        $p.csso()
        $p.uglify {preserveComments: 'some'}
      .pipe $.dest 'lib2', {cwd: "app/#{questions[0].name}"}
      .pipe $p.notify 'Create <%= file.relative %>'
      .on 'end', -> done()

$.task 'stylelib', (done) ->
  {stylelib, styleFilename} = questions
  selectLib [stylelib, styleFilename], done

$.task 'scriptlib', (done) ->
  {scriptlib, scriptFilename} = questions
  selectLib [scriptlib, scriptFilename], done
