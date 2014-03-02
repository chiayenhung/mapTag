mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

User = new Schema
  id: ObjectId
  username: String
  name: String
  password: String

module.exports = mongoose.model 'User', User
