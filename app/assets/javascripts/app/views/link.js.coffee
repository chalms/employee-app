class Web.Views.Link extends Marionette.ItemView
  template: JST['/link']

  initialize: ->
    @model.on 'change', @render

  render: ->
    $(@el).html(@template())
    @