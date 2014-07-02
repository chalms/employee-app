Metrics.Routers.AppRouter = Backbone.Router.extend
  siteLayout: null
  json: null

  initialize: ->
    @json = @setAuthToken()

  launch: -> 
    user = new Metrics.Models.User(@json.user)
    @siteLayout = new Metrics.Views.SiteLayout(model: user)
    navbar = new Metrics.Views.SiteNavbar(model: user)
    footer = new Metrics.Views.SiteFooter(model: user)

    $('#user-data').html(@siteLayout.render().el)

    @siteLayout.siteNavbar.show navbar
    @siteLayout.showHome()
    @siteLayout.siteFooter.show footer

  setAuthToken: -> 
    console.log "Set auth token"
    data = $('#user-data').attr('user_hash')
    auth = $('#session-token').attr('token')
    sessionStorage.auth = auth
    console.log data
    console.log auth
    json = $.parseJSON(data)
    console.log json
    $('meta[name = "csrf-token"]').each ->
      console.log @
      json['csrf-token'] = @.content
    json['auth_token'] = auth
    console.log json
    return json 

  reports: (user) -> 
    return new Metrics.Views.Reports(model: user) 
    
  new_report: (user) -> 
    console.log "creating new report"
    return new Metrics.Views.NewReport(model: user)

  tasks: (report) -> 
    @employees = new Metrics.Views.Tasks(model: user)

  taskApp: (user) -> 
    return new Metrics.Views.TasksLayout(model: user)

  reportClient: (user) -> 
    return new Metrics.Views.ClientLayout(model: user)

  editPressed: (user) ->
    @siteForm = new Metrics.Views.EditAccount(model: user)
    @siteLayout.siteForm.show @siteForm
    $(document).ready ->
      $('#editAccount').modal 'show'
      $('#editAccount').on 'shown', ->
        $("#user_password").focus()

  routes:
    '/users/:': 'show',

  getClients: ->
    that = @
    $.ajax
      url: 'api/reports'
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "Failure"
      success: (data, textStatus, jqXHR) ->
        console.log data
        json = data
        console.log json
        i = 0
        collection = new Metrics.Collections.Clients()
        console.log collection
        for k, v of json
          collection.add(v)

        clients = new Metrics.Views.Clients(collection: collection)
        console.log clients
        console.log that.siteLayout
        that.siteLayout.clients.show clients
        clients.render()


