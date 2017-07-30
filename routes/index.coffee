express = require 'express'
router = express.Router()
Poll = require '../models/polls'
passportGithub = require '../auth/github'
passportTwitter = require '../auth/twitter'

all = require './all'
myPolls = require './polls'

router.use (req, res, next) ->
	if req.isAuthenticated()
		res.locals.isLogged = true
	else
		res.locals.isLogged = false
	next()

# GET home page.
router.use '/', all

# Login Page
router.get '/login', (req, res, next) ->
	res.render 'login'

# Github Auth
router.get '/auth/github', passportGithub.authenticate('github', scope: [ 'user:email' ])

# Github Callback
router.get '/auth/github/callback', passportGithub.authenticate('github', failureRedirect: '/login'), (req, res) ->
	res.redirect '/polls/me'

# Twitter Auth
router.get '/auth/twitter', passportTwitter.authenticate('twitter')

# Twitter Callback
router.get 'auth/twitter/callback', passportTwitter.authenticate('twitter', failureRedirect: '/login'), (req, res) ->
	res.redirect '/polls/me'

# Logout
router.get '/logout', (req,res) ->
	req.logout()
	res.redirect '/'

# Polls
router.use '/polls', myPolls

module.exports = router
