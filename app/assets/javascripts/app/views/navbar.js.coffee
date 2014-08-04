class Web.Views.Navbar extends Backbone.Marionette.ItemView
  el: null,
  theEl: null,
  template: JST['/navbar']

  initialize: (args, theEl) ->
    super (args)
    @theEl = theEl
    getEl()
    @

  getEl: ->
    if not (@el)
      @el = @theEl
    @el

  render: ->
    $(getEl()).html(@template())
    @





