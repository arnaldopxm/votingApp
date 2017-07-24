express = require 'express'
router = express.Router()

# GET home page.
router.get '/', (req, res, next) ->
	res.render 'login'

module.exports = router;
