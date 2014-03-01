fs = require 'fs'
jade = require 'jade'

module.exports = (grunt) ->

  # load external grunt tasks
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-env'

  DEV_PATH = "app"
  PRODUCTION_PATH = "dist"


  grunt.initConfig
    clean:
      development: "#{PRODUCTION_PATH}"

    copy:
      development:
        files: [
          { expand: true, cwd: "#{DEV_PATH}/public", src:['**'], dest: PRODUCTION_PATH }
        ]

    express:
      test:
        options:
          server: './server/server'
          port: 5000
      development:
        options:
          server: './server/server'
          port: 3000    

    jade:
      development:
        options:
          pretty: false

        files: [
          {
            src: "#{DEV_PATH}/index.jade"
            dest: "#{PRODUCTION_PATH}/index.html"
          }
        ]

    sass:
      development:
        files: [
          expand: true
          cwd: "#{DEV_PATH}/styles"
          src: ['*.sass']
          dest: "#{PRODUCTION_PATH}/styles"
          ext: ".css"
        ]


    coffee:
      development:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: "#{DEV_PATH}/coffee"
          dest: "#{PRODUCTION_PATH}/js"
          src: ["*.coffee", "**/*.coffee"]
          ext: ".js"
        ]

    watch:
      coffee:
        files: ["#{DEV_PATH}/coffee/*.coffee", "#{DEV_PATH}/coffee/*/*.coffee","#{DEV_PATH}/coffee/*/*/*.coffee"]
        tasks: 'coffee:development'
      sass:
        files: ["{DEV_PATH}/styles/*.sass", "#{DEV_PATH}/styles/**/*.sass"]
        tasks: 'sass:development'
      jade:
        files: ["#{DEV_PATH}/index.jade", "#{DEV_PATH}/partials/*.jade", "#{DEV_PATH}/partials/**/*.jade"]
        tasks: ['jade:development', 'clientTemplates']

  grunt.registerTask 'clientTemplates', 'Compile and concatenate Jade templates for client.', ->
    templates = {}

    if not templates.length
      return

    tmplFileContents = "define(['jade'], function(jade) {\n"
    tmplFileContents += 'var JST = {};\n'

    for namespace, filename of templates
      path = "#{__dirname}/#{filename}"
      contents = jade.compile(
        fs.readFileSync(path, 'utf8'), { client: true, compileDebug: false, filename: path }
      ).toString()
      tmplFileContents += "JST['#{namespace}'] = #{contents};\n"
      
    tmplFileContents += 'return JST;\n'
    tmplFileContents += '});\n'
    fs.writeFileSync "#{PRODUCTION_PATH}/js/templates.js", tmplFileContents

  grunt.registerTask 'development', [
    'clean:development'
    'copy:development'
    'coffee:development'
    'sass:development'
    'jade:development'
    'clientTemplates'
  ]

  grunt.registerTask 'default', [
    'development'
    'express:development'
    'watch'
  ]
