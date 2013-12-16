module.exports = (config) ->
	config.set
		# hostname used when capturing browsers
		hostname: 'localhost'

		# base path, used to resolve file includes and excludes
		basePath: './'

		# Watch files? No, we use Grunt for this instead
		autoWatch: false

		# web server port
		port: 3000

		# frameworks to use
		frameworks: ['mocha', 'requirejs']

		# list of files / patterns to load in the browser
		files: [
			'public/**/*.js'
			'public-test/**/*.coffee'
		]

		# list of files to exclude
		exclude: [ ]

		# test results reporter to use
		# possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
		reporters: ['progress']

		# enable / disable colors in the output (reporters and logs)
		colors: true

		# level of logging
		# possible values: 
		#	config.LOG_DISABLE
		#	config.LOG_ERROR
		#	config.LOG_WARN
		#	config.LOG_INFO
		#	config.LOG_DEBUG
		logLevel: config.LOG_DEBUG

		# Start these browsers, currently available:
		# - Chrome
		# - ChromeCanary
		# - Firefox
		# - Opera (has to be installed with `npm install karma-opera-launcher`)
		# - Safari (only Mac; has to be installed with `npm install karma-safari-launcher`)
		# - PhantomJS
		# - IE (only Windows; has to be installed with `npm install karma-ie-launcher`)
		browsers: ['Chrome', 'Firefox', 'PhantomJS']

		# If browser does not capture in given timeout [ms], kill it
		captureTimeout: 6000,

		# Continuous Integration mode
		# if true, it capture browsers, run tests and exit
		singleRun: true
