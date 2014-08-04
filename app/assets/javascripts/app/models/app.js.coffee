class Web.Models.App extends Backbone.Marionette.Model

  defaults: {
    'navbar': @getNavbar,
    'sidebar': @getSidebar,
    'main': @getMain
  }

  models: {
    'projects': @getProjects,
    'employees': @getEmployees,
    'clients': @getClients
  }

  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults[key]())

  getNavbar: ->
    new Web.Models.Navbar

  getSidebar: ->
    new Web.Models.Sidebar

  getProjects: ->
    new Web.Models.Projects(@.get('projects'))

  getEmployees: ->
    new Web.Models.Employees(@.get('employees'))

  getClients: ->
    new Web.Models.Clients(@.get('clients'))

  getMain: ->
    main = @.get('main')
    for k in @models
      if main is k
        @.set(k, @models[k])
        break
    main




