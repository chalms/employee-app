class Web.Views.Link extends Marionette.ItemView
  template: JST['/subnav-link']

  events:
    'click' : @linkClicked

  initialize: ->
    @model.on 'change', @render

  linkClicked: ->
    @model.set('selected', true)
    Web.commands.execute('switch', @model.get('href'))

  render: ->
    $(@el).html(@template())
    @