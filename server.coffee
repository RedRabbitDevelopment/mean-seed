server = require './server/server'

server.run (port)->
	console.log "Listening on port " + port
