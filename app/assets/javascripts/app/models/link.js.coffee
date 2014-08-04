class Web.Models.Link extends Backbone.Marionette.Model

  checkSelected: (activeView) ->
    if @.get('name') is activeView
      @.set('selected', true)