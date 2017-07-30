ids =
	github :
		clientID : process.env.GITHUBCLI
		clientSecret : process.env.GITHUBSEC
		callbackURL : process.env.HOST + 'auth/github/callback'
	twitter :
		consumerKey : process.env.TWITTERCLI
		consumerSecret : process.env.TWITTERSEC
		callbackURL : process.env.HOST + 'auth/twitter/callback'

module.exports = ids
