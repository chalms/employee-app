#= require_tree .
#= require_tree ../../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers
#= require_tree ./views


class Web extends Backbone.Marionette.Application
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Layouts: {}

Web = new Web

Web.addInitializer (options) ->
  console.log("initializer called")
  new Web.Routers.App

Web.on "start", (options) ->
  Backbone.history.start()  if Backbone.history
  return
