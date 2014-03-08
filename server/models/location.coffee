mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Location = new Schema
  id: ObjectId
  userId: String
  latitue: Number
  longitude: Number
  photo: [String]
  memo: String

module.exports = mongoose.model 'Location', Location
