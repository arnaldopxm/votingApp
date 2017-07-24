passport = require 'passport'
User = require '../models/user'

module.exports = ->
	passport.serializeUser (user,done) ->
		done null, user.id
	passport.deserializeUser (id,done) ->
		User.findById id,(err,usr) ->
			done err, usr
