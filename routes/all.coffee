express = require 'express'
router = express.Router()
Poll = require '../models/polls'

router.get '/', (req, res, next) ->
	Poll.find {}, (err,data) ->
		res.render 'index', {data}

module.exports = router;
