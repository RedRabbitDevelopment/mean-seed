express = require 'express'
app = express()
routes = require './routes'

app.get "/", routes.index

app.listen 3000
console.log "listening on port 3000"

module.exports =
	run: (callback)->
		app.listen app.get('port'), ->
			callback app.get 'port'
	stop: (callback)->
		app.close callback
