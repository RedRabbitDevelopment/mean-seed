
express = require 'express'
app = express()
console.log 'booya'

module.exports =
	run: (callback)->
		app.listen app.get('port'), ->
			callback app.get 'port'
	stop: (callback)->
		app.close callback
