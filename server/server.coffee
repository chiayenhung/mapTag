express = require 'express'
mongoose = require 'mongoose'

userControler = require './controlers/userControler'

app = express()

mongoose.connect 'mongodb://localhost/mapTag'

app.configure ->
  app.use express.compress()
  app.set 'title', "Map Tag"
  app.set 'views', "#{__dirname}/templates"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.static("#{__dirname}/../dist/")

  app.post '/signup', userControler.signup

module.exports = app
