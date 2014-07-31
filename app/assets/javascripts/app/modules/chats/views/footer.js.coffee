class Metrics.Views.Footer extends Backbone.View
  el: '#chats-footer'
  template: JST['chats/footer']
  initialize: ->
    @collection.bind 'add', @updateRemaining, @
    @collection.bind 'remove', @updateRemaining, @

  render: ->
    unread = @collection.unread.length
    $(@el).html(@template({unread: unread}))
    @
