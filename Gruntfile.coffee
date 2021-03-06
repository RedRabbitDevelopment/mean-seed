module.exports = (grunt)->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		files:
			server: 'server-src/'
			serverBuild: 'server/'
			serverTest: 'server-test/'
			frontend: 'public-src/'
			frontendBuild: 'public/'
			frontendTest: 'public-test/'
			frontendCompiled: 'public/js/app.js'
		coffee:
			'compile-server':
				options:
					bare: true
				files: [{
					expand: true
					cwd: '<%= files.server %>'
					src: ['**/*.coffee']
					dest: '<%= files.serverBuild %>'
					ext: '.js'
					},{
					expand: true
					src: ['server.coffee']
					dest: ''
					ext: '.js'
				}]
			'compile-frontend':
				files: [
					expand: true
					cwd: '<%= files.frontend %>'
					src: ['**/*.coffee']
					dest: '<%= files.frontendBuild %>'
					ext: '.js'
				]

		less:
			compile:
				files:
					'<%= files.frontendBuild %>css/app.css':
						'<%= files.frontend %>css/app.less'

		copy:
			main:
				files: [
					expand: true
					cwd: '<%= files.frontend %>'
					src: ['**/*.html']
					dest: '<%= files.frontendBuild %>'
					]

		uglify:
			options:
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
			build:
				files:
					'<%= files.frontendCompiled %>': [
						'<%= files.frontendBuild %>js/**/*.js',
						'!<%= files.frontendBuild %>js/lib/**/*.js',
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

		watch:
			'coffee-frontend':
				files: ['<%= files.frontend %>/**/*.coffee']
				tasks: [
					'newer:coffee:compile-frontend',
					'newer:copy',
					'newer:less',
					'newer:uglify',
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
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-mocha-test'
	grunt.loadNpmTasks 'grunt-newer'
	grunt.loadNpmTasks 'grunt-karma'

	grunt.registerTask 'default', [
		'newer:coffee',
		'newer:less',
		'newer:copy',
		'newer:uglify',
		'mochaTest',
		'karma'
		]
