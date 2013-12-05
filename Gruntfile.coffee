module.exports = (grunt)->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		files:
			server: 'server/'
			serverBin: 'bin/'
			frontend: 'frontend/'
			frontendBin: 'public/js/'
			frontendCompiled: 'public/js/app.js'
		coffee:
			'compile-server':
				options:
					bare: true
				files: [
					expand: true
					cwd: '<%= files.server %>'
					src: ['**/*.coffee']
					dest: '<%= files.serverBin %>'
					ext: '.js'
				]
			'compile-frontend':
				files: [
					expand: true
					cwd: '<%= files.frontend %>'
					src: ['**/*.coffee']
					dest: '<%= files.frontendBin %>'
					ext: '.js'
				]
		uglify:
			options:
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
			build:
				files:
					'<%= files.frontendCompiled %>': ['public/js/**/*.js', '!public/js/lib/**/*.js', '!<%= files.frontendCompiled %>']
		karma:
			unit:
				configFile: 'karma.config.coffee'
				background: true
		watch:
			karma:
				files: ['<%= files.frontend %>/**/*.coffee', '<%= files.server %>/**/*.coffee']
				tasks: ['karma:unit:run']
	
	grunt.event.on 'watch', (action, filepath, target)->
		if target is 'runTest'
			specExt = '.spec.coffee'
			testpath = if (filepath.length - specExt.length) is filepath.indexOf specExt
				# is test
				filepath
			else
				filepath.substr(0, filepath.length - '.coffee'.length) + specExt
			console.log 'running', testpath
			grunt.config 'mochaTest.test.src', testpath
	
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-karma'

	grunt.registerTask 'default', 'coffee uglify'.split ' '
