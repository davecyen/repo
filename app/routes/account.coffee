app = module.exports = require('lib/config')()
ensureAuthenticated = app.get 'ensureAuthenticated'

app.get '/account', ensureAuthenticated, (req,res) ->
  
  res.render 'account', 
    title: 'Account'
    user: req.user