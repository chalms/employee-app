class Metrics.Views.ChatsIndex extends Backbone.View
  el: '#chats-index'
  template: JST['chats/index']
  events:
      'keypress #add-chat' : 'createOnEnter'

  initialize: ->

    console.log "ininitalize chats/index view called"

    @collection.bind 'reset', @render, @
    @collection.bind 'add', @addTask, @

  addChat: (chat) ->
    view = new Metrics.Views.ChatsItem
    @$('#chats').append(view.render().el)
    @

  render: ->

    console.log "rendering chats tmeplate "

    $(@el).html(@template())

    footerView = new Metrics.Views.Footer collection: @collection
    footerView.render()

    @collection.each (chat) =>
      view = new Metrics.Views.ChatsItem model: chat
      @$('#tasks').append(view.render.el)

    @
  createOnEnter: (event) ->
    console.log "creating chats"
    return if event.keyCode != 13
    @collection.create name: @$('#add-chat').value
    @$('#add-chat').val('')


