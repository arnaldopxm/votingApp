express = require 'express'
router = express.Router()
Poll = require '../models/polls'

redirLog = (req,res,next) ->
	if req.isAuthenticated()
		next()
	else
		res.redirect '/login'

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
router.get '/new', redirLog, (req, res, next) ->
	res.render 'new'

router.post '/new', redirLog, (req, res, next) ->
	user = req.user.someID
	question = req.body.title
	opts = req.body.opts.split '\r\n'
	answers = for id, val of opts
		{ opt : val, votes: 0}

	poll = new Poll {user,question,answers}
	poll.save (err) ->
		res.redirect '/polls/me'


# Vote on a poll
router.get '/:pid', (req,res,next) ->
	pid = req.params.pid
	searchQuery =
		_id : pid

	Poll.findOne searchQuery, (err,data) ->
		owner = if req.isAuthenticated() then req.user.someID else null
		isOwner = String owner == String data.user
		data.own = isOwner
		data.pid = pid
		res.render 'view', {data}

router.post '/:pid', (req,res,next) ->
	pid = req.params.pid
	answer = req.body.answer

	if answer == 'other'
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

require('plotly')('arnaldopxm', '9qNG0DzU8ZxV9cXxdKhF');

var data = [
  {
    x: ["giraffes", "orangutans", "monkeys"],
    y: [20, 14, 23],
    type: "bar"
  }
];
var graphOptions = {filename: "basic-bar", fileopt: "overwrite"};
plotly.plot(data, graphOptions, function (err, msg) {
    console.log(msg);
});
