User = require '../models/user'

userControler = {}

userControler.signup = (req, res) ->
  res.render 'signup'

userControler.createUser = (req, res) ->
  console.log req.body
  user = new User
    username: req.body.username
    name: req.body.name
    password: req.body.password
  user.save (err) ->
    if err
      res.send 500, err
    else
      res.send @

module.exports = userControler