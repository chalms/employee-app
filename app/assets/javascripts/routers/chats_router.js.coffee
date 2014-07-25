class Metrics.Routers.Chats extends Backbone.Router
  routes:
    '/chats' : 'index'
  chatsIndex: null

  initialize: ->
    console.log "ininitalize routes called"
    @index();

  index: ->
    console.log "index called"
    console.log "fetching chats"
    chats = new Metrics.Collections.Chats
    chatsIndex = new Metrics.Views.ChatsIndex collection:chats
    chats.fetch()