express = require 'express'
mongoose = require 'mongoose'

userControler = require './controlers/userControler'

app = express()

mongoose.connect 'mongodb://localhost/mapTag'

app.configure ->
  app.use express.compress()
  app.set 'title', "Map Tag"
  app.set 'views', "#{__dirname}/pages"
  app.set 'view engine', 'jade'
  app.set express.cookieParser()
  app.use express.bodyParser()
  app.use express.static("#{__dirname}/../dist/")

  app.get '/signin', userControler.showSignin
  app.post '/signin', userControler.singin
  app.get '/signup', userControler.signup
  app.post '/signup', userControler.createUser

module.exports = app
