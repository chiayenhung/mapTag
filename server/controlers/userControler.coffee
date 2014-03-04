User = require '../models/user'

userControler = {}

userControler.showSignin = (req, res) ->
  res.render 'signin'

userControler.singin = (req, res) ->
  username = req.body.username
  password = req.body.password
  if username and password
    User.findOne {username: username, password: password}, (err, user) ->
      if err
        res.send 500, err
      else if !user
        res.render 'signin'
      else
        res.redirect "/"

userControler.signup = (req, res) ->
  res.render 'signup'

userControler.createUser = (req, res) ->
  user = new User
    username: req.body.username
    name: req.body.name
    password: req.body.password
  user.save (err) ->
    if err
      res.send 500, err
    else
      res.redirect "/"

module.exports = userControler