Metrics.Routers.AppRouter = Backbone.Router.extend
  siteLayout: null
  json: null

  initialize: ->
    data = $('#user-data').attr('user_hash')
    auth = $('#session-token').attr('token')
    sessionStorage.auth = auth
    json = $.parseJSON(data)
    $('meta[name = "csrf-token"]').each ->
      json['csrf-token'] = @.content
    json['auth_token'] = auth
    @json = json 

  launch: -> 
    user = new Metrics.Models.User(@json.user)
    @siteLayout = new Metrics.Views.SiteLayout(model: user)
    navbar = new Metrics.Views.SiteNavbar(model: user)
    footer = new Metrics.Views.SiteFooter(model: user)
    $('#user-data').html(@siteLayout.render().el)
    @siteLayout.siteNavbar.show navbar
    @siteLayout.showHome()
    @siteLayout.siteFooter.show footer

  user_reports: (user) -> 
    return new Metrics.Collections.Reports(user.reports)

  report_tasks: (report) -> 
    return new Metrics.Collections.Tasks(report.tasks)

  view_reports: (user) -> 
    if @reports == undefined then @reports = new Metrics.Views.Reports(collection: user_reports(user)) 

  new_report: (user) -> 
    return if @report == undefined then @report = new Metrics.Views.NewReport(model: new Metrics.Models.Report({user: user}))

  tasks: (report) -> 
    @employees = new Metrics.Views.Tasks(collection: report_tasks(report))

  taskApp: (report) -> 
    return new Metrics.Views.TasksLayout(model: report)

  reportClient: (user) -> 
    return new Metrics.Views.ClientLayout(model: user)

  showHeader: (taskList) ->
    return new Metrics.Views.TasksHeader(model: taskList)

  showFooter: (taskList) ->
    return new Metrics.Views.TasksFooter(collection: taskList)

  showTaskList: (taskList) ->
    return new Metrics.Views.Tasks(model: taskList)

  editPressed: (user) ->
    @siteForm = new Metrics.Views.EditAccount(model: user)
    @siteLayout.siteForm.show @siteForm

  routes:
    '/users/:': 'show',

  getClients: ->
    that = @
    $.ajax
      url: 'api/reports'
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log errorThrown
      success: (data, textStatus, jqXHR) ->
        json = data
        i = 0
        collection = new Metrics.Collections.Clients()
        for k, v of json
          collection.add(v)
        clients = new Metrics.Views.Clients(collection: collection)
        that.siteLayout.clients.show clients
        clients.render()



