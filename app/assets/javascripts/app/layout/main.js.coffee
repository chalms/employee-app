class Web.Layouts.Main extends Backbone.Marionette.Layout

  template: JST['/main']

  subnavView: null
  projectsView: null,
  employeesView: null,
  clientsView: null,
  theModel: null

  regions: {
    subnav: '#subnav'
    content: '#content'
  }

  initialize: (args) ->
    super(args)
    @showProjectsView()
    @setSubnav()
    @setHandler()

  setSubnav: ->
    subnavModel = new Web.Models.Subnav(@theModel.get('links'))
    if @subnavView then @subnavView = @subnavView(model: subnavModel) else @subnavView = new Web.Views.Subnav(model: subnavModel)
    subnav.show(@subnavModel)

  setHandler: ->
    Web.commands.setHandler "switch", (data) ->
      @theModel = data
      content.currentView.switch(@theModel)
      subnav.model = new Web.Models.Subnav(@theModel.get('links'))
      return

  render: ->
    $(@el).html(@template())
    @

  showProjectsView: ->
    @theModel = @model.get('projects')
    if @projectsView then @projectsView = @projectsView(model: @theModel) else @projectsView = new Web.Views.Projects(model: @theModel)
    content.show(@projectsView)

  showEmployeesView: ->
    @theModel = @model.get('employees')
    if @employeesView then @employeesView = @employeesView(model: @theModel) else @employeesView = new Web.Views.Employees(model: @theModel)
    content.show(@employeesView)

  showClientsView: ->
    @theModel = @model.get('clients')
    if @clientsView then @clientsView = @clientsView(model: @theModel) else @clientsView = new Web.Views.Clients(model: @theModel)
    content.show(@clientsView)

