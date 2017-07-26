mongoose = require 'mongoose'
Schema = mongoose.Schema

# Create user schema
User = new Schema (
	name : String,
	someID : String
)

module.exports = mongoose.model 'users', User
