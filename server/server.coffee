express = require 'express'

app = express()

app.configure ->
  app.use express.compress()
  app.set 'views', "#{__dirname}/templates"
  app.set 'view engine', 'jade'
  app.use express.static("#{__dirname}/../dist/")

module.exports = app
