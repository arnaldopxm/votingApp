mongoose = require 'mongoose'
Schema = mongoose.Schema

Poll = new Schema (
	user : Number,
	question : String,
	answers : [{ opt : String, votes : Number }]
)

module.exports = mongoose.model 'polls', Poll
