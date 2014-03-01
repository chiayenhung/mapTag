express = require 'express'

app = express()

app.configure ->
  app.use express.compress()
  app.set 'views', "#{__dirname}/templates"
  app.set 'view engine', 'jade'

module.exports = app
