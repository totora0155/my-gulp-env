    # libnames = Object.keys(bowerPaths.js).map (libname) ->{name:libname}
    # libPath = libPath
    # jsPaths = null
    #
    # inquirer.prompt [
    #   type: 'checkbox'
    #   name: 'js'
    #   message: 'choice JS library'
    #   choices: libnames
    # ] , (answers) ->
    #   jsPaths = answers.js.map (libname) ->
    #     path.join 'bower_components', bowerPaths.js[libname]
    #   ignoreMinjsFilter = $.filter ['**/*.js', '!**/*.min.js']
    #   fwFilter = $.filter ['**/lib.js', '**/{mithril,angular}.min.js']
    #   jqueryUiFilter = $.filter ['**/lib.js', '**/jquery-ui.min.js']
    #   # jquery > jqueryUi > angular > other
    #   ignoreOtherFilter = $.filter ['**/*.js', '!**/{jquery*,angular,mithril}.min.js']
    #
    #   __.src jsPaths
    #     .pipe $.uglify
    #       output: {comments: true}
    #     .pipe ignoreOtherFilter
    #     .pipe $.concat 'lib.js'
    #     .pipe ignoreOtherFilter.restore()
    #     .pipe fwFilter
    #     .pipe $.concat 'lib.js'
    #     .pipe fwFilter.restore()
    #     .pipe jqueryUiFilter
    #     .pipe $.concat 'lib.js'
    #     .pipe jqueryUiFilter.restore()
    #     .pipe $.concat 'lib.js'
    #     # .pipe $.notify "copied! #{libPath} <- lib.js"
    #     .pipe __.dest libPath
    #     .pipe $.size {showFile: true, title: 'lib.js'}
