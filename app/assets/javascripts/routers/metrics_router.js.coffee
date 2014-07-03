Metrics.Routers.AppRouter = Backbone.Router.extend
  siteLayout: null
  json: null
  newReportLayout: null
  taskApp: null


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
    console.log "calling new report"
    @build_report(@siteLayout.siteHome)
    @siteLayout.siteFooter.show footer

  task_app: (holder, report) -> 
    @taskApp = new Metrics.Views.TasksLayout(model: report)
    console.log @taskApp

    header = @tasks_header(report)
    taskList =  @tasks_composite_view(report)
    footer = @tasks_footer(report)

    $('#t').html(@taskApp.render().el)
    console.log $('#t').html()



    console.log header
    console.log @taskApp
    console.log @taskApp.regions


    @taskApp.taskHeader.show header
    @taskApp.taskList.show taskList
    @taskApp.taskFooter.show footer

  build_report: (holder) -> 
    console.log "new report called"
    report = @new_report(@json.user)
    @newReportLayout = @new_report_layout(report)
    $('#site-home').html(@newReportLayout.render().el)
    @task_app(@newReportLayout.task_app, report) 
    holder.show @newReportLayout


  user_reports: (user) -> 
    return new Metrics.Collections.Reports(user.reports)

  report_tasks: (report) -> 
    console.log "choosing to show new task collection --- change later"
    return new Metrics.Collections.Tasks

  view_reports: (user) -> 
    if @reports == undefined then @reports = new Metrics.Views.Reports(collection: @user_reports(user)) 

  new_report: (user) -> 
    return new Metrics.Models.Report(user: user)

  new_report_layout: (report) -> 
    return new Metrics.Views.NewReportLayout(model: report)

  tasks_composite_view: (report) -> 
    return new Metrics.Views.Tasks(collection: @report_tasks(report), model: report)

  tasks_layout: (report) -> 
    return new Metrics.Views.TasksLayout(model: report)

  reportClient: (user) -> 
    return new Metrics.Views.ClientLayout(model: user)

  tasks_header: (report) ->
    return new Metrics.Views.TasksHeader(model: report)

  tasks_footer: (report) ->
    return new Metrics.Views.TasksFooter(model: report)

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



