express = require 'express'
router = express.Router()

# GET home page.
router.get '/', (req, res, next) ->
	res.send 'respond with a resource'

module.exports = router;
