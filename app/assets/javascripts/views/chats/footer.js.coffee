class Metrics.Views.Footer extends Backbone.View
  el: '#footer'
  template: JST['tasks/footer']
  initialize: ->
    @collection.bind 'add', @updateRemaining, @
    @collection.bind 'remove', @updateRemaining, @

  render: ->
    remaining = @collection.length
    $(@el).html(@template({remaining: remaining}))
    @
  updateRemaining: ->
    @$('#task-count').text(@collection.length)