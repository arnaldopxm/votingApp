express = require 'express'
router = express.Router()

passportGithub = require '../auth/github'

router.use (req, res, next) ->
	if req.isAuthenticated()
		res.locals.isLogged = true
	else
		res.locals.isLogged = false
	next()

# GET home page.
router.get '/', (req, res, next) ->
	res.render 'index', { title: 'Express' }

router.get '/users', (req, res, next) ->
	res.send 'respond with a resource'

router.get '/login', (req, res, next) ->
	res.render 'login'

router.get '/auth/github', passportGithub.authenticate('github', scope: [ 'user:email' ])

router.get '/auth/github/callback', passportGithub.authenticate('github', failureRedirect: '/login'), (req, res) ->
	res.redirect '/'

router.get '/logout', (req,res) ->
	req.logout()
	res.redirect '/'

module.exports = router
