express = require 'express'
app = express()
routes = require './routes'

app.use express.static(__dirname + "/../public")
app.set "view engine", "ejs"
app.engine 'html', require('ejs').renderFile

app.get "/", routes.index

app.set 'port', 3000
app.set 'views', '../public'

module.exports =
	run: (callback)->
		app.listen app.get('port'), ->
			callback app.get 'port'
	stop: (callback)->
		app.close callback
