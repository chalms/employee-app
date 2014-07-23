class Metrics.Routers.Chats extends Backbone.Router
  routes:
    '' : 'index'

  index: ->
    chats = new Metrics.Collections.Chats
    new Metrics.Views.ChatsIndex collection:chats
    console.log "fetching chats"
    chats.fetch()