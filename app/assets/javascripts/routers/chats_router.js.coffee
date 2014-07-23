class Metrics.Routers.Chats extends Backbone.Router
  routes:
    '/chats' : 'index'

  initialize: ->
    console.log "ininitalize routes called"

  index: ->
    console.log "index called"
    chats = new Metrics.Collections.Chats({chat: "fuck you"})
    new Metrics.Views.ChatsIndex collection:chats
    console.log "fetching chats"
    chats.fetch()