window.Metrics =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Metrics.Routers.Chats
    Backbone.history.start()


$(document).ready ->
  Metrics.init()
