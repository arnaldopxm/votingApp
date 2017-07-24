express = require 'express'
router = express.Router()
passport = require 'passport'

# GET home page.
router.get '/', (req, res, next) ->
	res.send 'respond with a resource'

# router.get '/', (req, res, next) ->
#   passport.authenticate('basic', (err, user, info) ->
#     return next(err) if (err)
#     return res.redirect('/login') if (!user)
#     req.logIn user, (err) ->
#       return next(err) if (err)
#       return res.redirect '/users/' + user.username
#   )(req, res, next)


module.exports = router;
