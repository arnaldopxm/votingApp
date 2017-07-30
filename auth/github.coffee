passport = require('passport')
GitHubStrategy = require('passport-github2').Strategy
User = require('../models/user')
config = require('../.config')
init = require('./init')

passport.use new GitHubStrategy({
  clientID: config.github.clientID
  clientSecret: config.github.clientSecret
  callbackURL: config.github.callbackURL
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
