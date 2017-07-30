express = require 'express'
csrf = require('csurf')
Poll = require '../models/polls'
router = express.Router()

redirLog = (req,res,next) ->
	if req.isAuthenticated()
		next()
	else
		res.redirect '/login'

csrfProtection = csrf(cookie:true)

# See my polls
router.get '/me', redirLog, (req, res, next) ->
	searchQuery =
		user: req.user.someID

	Poll.find searchQuery, (err,data) ->
		res.render 'me', {data}

# Delete a poll
router.get '/:pid/del', redirLog, (req,res,next) ->
	Poll.findByIdAndRemove req.params.pid, (err,doc) ->
		res.redirect '/polls/me'

# Create a new poll
router.get '/new', redirLog, csrfProtection, (req, res, next) ->
	csrfToken = req.csrfToken()
	res.render 'new', {csrfToken}

router.post '/new', redirLog, csrfProtection, (req, res, next) ->
	user = req.user.someID
	question = req.body.title
	opts = req.body.opts.split '\r\n'
	answers = for id, val of opts
		{ opt : val, votes: 0}

	poll = new Poll {user,question,answers}
	poll.save (err) ->
		res.redirect '/polls/me'


# Vote on a poll
router.get '/:pid', csrfProtection, (req,res,next) ->
	pid = req.params.pid
	searchQuery =
		_id : pid

	Poll.findOne searchQuery, (err,data) ->
		if err
			next()
			return
		owner = if req.isAuthenticated() then req.user.someID else null
		isOwner = String owner == String data.user
		data.url = process.env.HOST + 'polls/' + pid
		data.own = isOwner
		data.pid = pid
		csrfToken = req.csrfToken()
		res.render 'view', {data,csrfToken}

router.post '/:pid', csrfProtection, (req,res,next) ->
	pid = req.params.pid
	answer = req.body.answer

	if answer == 'none'
		answer = req.body.other
		searchQuery =
			_id : pid
		updates =
			$addToSet :
				answers :
					opt : answer
					votes : 1
		Poll.update searchQuery, updates, (err,data) ->
			res.redirect '/polls/'+pid
	else
		searchQuery =
			_id : pid
			"answers.opt" : answer
		updates =
			$inc : {'answers.$.votes' : 1}
		options =
			upsert : false
		Poll.findOneAndUpdate searchQuery, updates, options, (err, data) ->
			res.redirect '/polls/'+pid

module.exports = router;
