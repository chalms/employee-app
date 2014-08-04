class Web.Views.Sidebar extends Backbone.Marionette.CompositeView
  el: null,
  theEl: null,
  linkList: '#links'
  template: JST['/sidebar']

  initialize: ->
    super (args)
    @model.bind 'change', @.setSelected(),
    @theEl = theEl
    getEl()
    @

  getEl: ->
    if not (@el)
      @el = @theEl
    @el

  render: ->
    $(@getEl()).html(@template())
    @collection.each (link) =>
      view = new Web.Views.Link model: link
      $(@linkList).append(view.render().el)

