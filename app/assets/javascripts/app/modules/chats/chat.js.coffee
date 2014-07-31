#= require_tree ../../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers
#= require_tree ./views
#= require_tree .

window.Chat =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    new App.Routers.Chats
    Backbone.history.start()
