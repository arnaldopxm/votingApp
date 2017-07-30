passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy
User = require '../models/user'
config = require '../.config'
init = require './init'

passport.use new TwitterStrategy({
	consumerKey: config.twitter.consumerKey
	consumerSecret: config.twitter.consumerSecret
	callbackURL: config.twitter.callbackURL
}, (accessToken, refreshToken, profile, done) ->
	searchQuery = name: profile.displayName
	updates =
		name: profile.displayName
		someID: profile.id
	options = upsert: true
	# update the user if s/he exists or add a new user
	User.findOneAndUpdate searchQuery, updates, options, (err, user) ->
		if err
			done err
		else
			done null, user
	return
)
# serialize user into the session
init()

module.exports = passport
