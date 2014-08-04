class Web.Layouts.App extends Backbone.Marionette.LayoutView

  template: JST['/app']
  sidebar: null,
  navbar: null,
  main: null

  views: {
    'projects' : @getProjectsView,
    'clients' : @getClientsView,
    'employees' : @getEmployeesView
  }

  region: {
    '#navbar' : @getNavbar,
    '#sidebar' : @getSidebar,
    '#main': @getMain
  },

  initialize: ->
    @model.bind 'change', @render, @
    @render()

  render: ->
    region.each (regionName) ->
      $(regionName).html(region[regionName])

  getMain: ->
    @main.show(new Web.Layouts.Main(model: @model))

  getNavbar: ->
    @navbar.show(new Web.Views.Navbar(model: @model))

  getSidebar: ->
    @sidebar.show(new Web.Views.Sidebar(model: @model))

