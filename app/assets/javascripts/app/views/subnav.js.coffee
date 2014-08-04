class Web.Views.Subnav extends Backbone.Marionette.CompositeView
  template: ['/subnav']
  linkList: ['#subnav-links']

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
      view = new Web.Views.SubnavLink model: link
      $(@linkList).append(view.rend