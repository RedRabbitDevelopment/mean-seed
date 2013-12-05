
server = require './server/server'

server.open (port)->
	console.log "Listening on port #{port}"
