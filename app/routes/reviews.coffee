app = module.exports = require('lib/config')()
mongoose = require 'mongoose'
Module = mongoose.model 'Module'
Review = mongoose.model "Review"
ensureAuthenticated = app.get('ensureAuthenticated')


app.get "/review/new/module/:name", ensureAuthenticated, (req,res) ->

  res.render 'new_review',
    title: "Write a new review"
    module: 
      name: req.params.name
    user : req.user 

app.post "/reviews", (req,res) ->
  module_name = req.body.review.module
  review = req.body.review
  review.user = req.user

  Module.findOne {name:module_name}, (err, module)->
    if err or !module
      console.log(err)
      res.send(err)
    else
      module.reviews.push req.body.review
      module.save (err)->
        if err 
          console.log(err)
          res.send(err)
        else 
          console.log('review for: ' + module.name + " saved.") 
          res.redirect('/module/'+module.name)


app.get "/test", (req,res) ->
  res.render 'new_review',
    title: "Write a new review"
    module: 
      name: req.params.name
    user : {}