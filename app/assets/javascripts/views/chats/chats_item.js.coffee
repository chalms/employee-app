class Metrics.Views.ChatsItem extends Backbone.View
  template: JST['chats/item']
  events:
    'click a.remove-task' : 'removeTask'
  initialize: ->
