class Metrics.Collections.Chats extends Backbone.Collection
  url: '/chats'
  model: Metrics.Models.Chat

  initialize: (args) ->
    super(args)
    console.log("created")

  unread: ->
    unread = 0
    @models.each (chat) ->
      unread += chat.get('unread_count')
    unread

