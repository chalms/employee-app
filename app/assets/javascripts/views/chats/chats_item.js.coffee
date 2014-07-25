class Metrics.Views.ChatsItem extends Backbone.View
  template: JST['chats/item']
  events:
    'click a.remove-chat' : 'removeChat'

  initialize: ->
    @model.on 'change', @render

  render: ->
    $(@el).html(@template())
    @

  removeChat: (e) ->
    console.log "#{e.toString} needs to be removed"