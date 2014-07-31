#= require_tree ../../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers
#= require_tree ./views
#= require_tree .

window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Web.Routers.App
    Backbone.history.start()
