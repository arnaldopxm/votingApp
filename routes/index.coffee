express = require 'express'
router = express.Router()
Poll = require '../models/polls'
passportGithub = require '../auth/github'

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

router.get '/login', (req, res, next) ->
	res.render 'login'

router.get '/auth/github', passportGithub.authenticate('github', scope: [ 'user:email' ])

router.get '/auth/github/callback', passportGithub.authenticate('github', failureRedirect: '/login'), (req, res) ->
	res.redirect '/polls/me'

router.get '/logout', (req,res) ->
	req.logout()
	res.redirect '/'

router.use '/polls', myPolls

module.exports = router
