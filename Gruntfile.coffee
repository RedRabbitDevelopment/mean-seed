module.exports = (grunt)->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		files:
			server: 'server-src/'
			serverBin: 'server/'
			serverTest: 'server-test/'
			frontend: 'public-src/'
			frontendBin: 'public/js/'
			frontendTest: 'frontend-test/'
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
					'<%= files.frontendCompiled %>': [
						'public/js/**/*.js',
						'!public/js/lib/**/*.js',
						'!<%= files.frontendCompiled %>'
						]

		mochaTest:
			frontend:
				options:
					reporter: 'spec'
				src: [
					'<%= files.frontendTest %>/**/*.coffee'
					]
			server:
				options:
					reporter: 'spec'
				src: [
					'<%= files.serverTest %>/**/*.coffee'
					]
		karma:
			unit:
				configFile: 'karma.config.coffee'
				background: true
		watch:
			'coffee-frontend':
				files: ['<%= files.frontend %>/**/*.coffee']
				tasks: [
					'newer:coffee:compile-frontend',
					'mochaTest:frontend',
					'karma'
					]

			'coffee-server':
				files: ['<%= files.server %>/**/*.coffee']
				tasks: [
					'newer:coffee:compile-server',
					'mochaTest:server'
					]

	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-mocha-test'
	grunt.loadNpmTasks 'grunt-newer'
	grunt.loadNpmTasks 'grunt-karma'

	grunt.registerTask 'default', 'newer:coffee newer:uglify mochaTest'.split ' '
