  class Metrics.Views.ChatsIndex extends Backbone.View
  el: '#chatsapp'
  template: JST['chats/index']
  events:
      'keypress #add-chat' : 'createOnEnter'

  initialize: ->
    console.log "ininitalize chats/index view called"
    @collection.bind 'reset', @render, @
    @collection.bind 'add', @addChat, @

  addChat: (chat) ->
    @render()
    view = new Metrics.Views.ChatsItem({ model: chat })
    # $(@el).find('#chats-index').append(view.render().el)
    # @

  render: ->
    @collection.each (chat) =>
      view = new Metrics.Views.ChatsItem model: chat
      $('#chats-index').append(view.render().el)
    @
    console.log "rendering chats tmeplate "
    $(@el).html(@template())
    footerView = new Metrics.Views.Footer collection: @collection
    footerView.render()

  createOnEnter: (event) ->
    console.log "creating chats"
    return if event.keyCode != 13
    @collection.create name: @$('#add-chat').value
    @$('#add-chat').val('')


