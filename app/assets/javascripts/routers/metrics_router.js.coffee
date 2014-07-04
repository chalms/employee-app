Metrics.Routers.AppRouter = Backbone.Router.extend
  siteLayout: null
  siteNav: null 
  siteFooter: null 

  report: null 
  reports: null 
  newReportLayout: null

  task: null
  taskCollection: null
  tasksCompositeView: null 
  tasksHeader: null 
  tasksFooter: null 
  tasksLayout: null 

  client: null 
  clients: null 
  clientLayout: null 

  editAccountView: null 

  json: null
  user: null 
  data: null 
  auth: null 

  initialize: ->
    @setSession()  

  launch: -> 
    $('#user-data').html(@getSiteLayout().render().el)
    @getSiteLayout().siteNavbar.show @getSiteNavbar()
    @getSiteLayout().siteHome.show @getNewReportLayout('#site-home')
    @showTaskLayout('#t') 
    @getSiteLayout().siteFooter.show @getSiteFooter()

  showTaskLayout: (str) -> 
    $(str).html(@getTasksLayout().render().el)
    @getTasksLayout().taskHeader.show @getTasksHeader() 
    @getTasksLayout().taskList.show @getTasksCompositeView()
    @getTasksLayout().taskFooter.show @getTasksFooter()

  setUser: (u) -> 
    @user = new Metrics.Models.User(u)

  getUser: -> 
    if @user is null then @user = new Metrics.Models.User(@json.user)
    return @user

  setSession: -> 
    @setJson($('#user-data').attr('user_hash'))
    @setAuth($('#session-token').attr('token')) 

  setJson: (data) -> 
    json = $.parseJSON(data)
    $('meta[name = "csrf-token"]').each ->
      json['csrf-token'] = @.content
    @json = json

  getAuth: -> 
    if @auth is null or undefined then @auth = sessionStorage.auth 
    return @auth 

  setAuth: (t) -> 
    if t then sessionStorage.auth = t and @auth = t 

  getSiteLayout: -> 
    if @siteLayout is null then @siteLayout = new Metrics.Views.SiteLayout(model: @getUser())
    return @siteLayout

  getSiteNavbar: -> 
    if @siteNav is null then @siteNav = new Metrics.Views.SiteNavbar(model: @getUser())
    return @siteNav 

  getSiteFooter: -> 
    if @siteFooter is null then @siteFooter = new Metrics.Views.SiteFooter(model: @getUser())
    return @siteFooter


  getReport: -> 
    if @report is null then @report = new Metrics.Models.Report(user_id: @getUser().id)
    return @report 

  setReport: (r) -> 
    @report = new Metrics.Models.Report(r)

  getUserReports: -> 
    if @reports is null then @reports = new Metrics.Collections.Reports(@getUser().reports)
    return @reports

  getNewReportLayout: (str) -> 
    if @newReportLayout is null then @newReportLayout = new Metrics.Views.NewReportLayout(model: @getReport())
    $(str).html(@newReportLayout.render().el)
    return @newReportLayout

  getReportsView: -> 
    if @reportsView is null then @reportsView = new Metrics.Views.Reports(collection: @getUserReports()) 
    return @reportsView 


  getTaskCollection: -> 
    if @taskCollection is null then @taskCollection = new Metrics.Collections.Tasks(@getReport().tasks)
    return @taskCollection


  getTasksLayout: -> 
    if @tasksLayout is null then @tasksLayout = new Metrics.Views.TasksLayout(model: @getReport())
    return @tasksLayout

  getTasksHeader: -> 
    if @tasksHeader is null then @tasksHeader = new Metrics.Views.TasksHeader(collection: @getTaskCollection())
    return @tasksHeader 

  getTasksFooter: -> 
    if @tasksFooter is null then @tasksFooter = new Metrics.Views.TasksFooter(collection: @getTaskCollection())
    return @tasksFooter

  getTasksCompositeView: (report) -> 
    if @tasksCompositeView is null then @tasksCompositeView = new Metrics.Views.Tasks(collection: @getTaskCollection(), model: @getReport())
    return @tasksCompositeView 


  getUserClients: -> 
    if @clients is null then @clients = new Metrics.Collections.Clients(@getUser().clients)
    return @clients

  clientLayout: -> 
    if @clientLayout is null then @clientLayout = new Matrics.Views.ClientLayout(model: @getUserClients())
    return @clientLayout

  getEditAccountView: -> 
    if @editAccountView is null then @editAccountView =  new Metrics.Views.EditAccount(model: @getUser())
    return @editAccountView 

  editPressed: ->
    @siteLayout.siteHome.hide 
    @siteLayout.siteHome.show @getEditAccountView()

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



