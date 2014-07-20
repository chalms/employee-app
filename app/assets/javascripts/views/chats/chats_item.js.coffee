class Metrics.Views.ChatsItem extends Backbone.View
  template: JST['tasks/item']
  events:
    'click a.remove-task' : 'removeTask'
  initialize: ->
