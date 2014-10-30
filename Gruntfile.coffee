module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        src: 'src/**/*.coffee',
        dest: '.grunt/',
        ext: '.js'
        expand: true,
        flatten: true

      benchmark:
        src: ['benchmarks/**/*.coffee']
        dest: 'benchmarks'
        ext: '.js'
        expand: true
        flatten: true

    uglify:
      dist:
        src: ['.grunt/**/*.js']
        dest: 'dist/queue.min.js'

    benchmark:
      all:
        src: ['benchmarks/**/*.js']
        dest: 'benchmarks/results.json'

    clean:
      compile: ['.grunt', 'dist']
      benchmark: ['benchmarks/**/*.js']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-benchmark'

  grunt.registerTask 'default', ['deploy']
  grunt.registerTask 'deploy', ['coffee:compile', 'uglify']
  grunt.registerTask 'profile', ['deploy', 'coffee:benchmark', 'benchmark']
