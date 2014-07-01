Metrics.Routers.AppRouter = Backbone.Router.extend
  siteLayout: null
  siteForm: null

  initialize: ->
    #json = $.parseJSON($('#navigation').attr('user_hash'))

    data = $('#user-data').attr('user_hash')
    console.log data

    json = $.parseJSON(data)
    console.log json

    $('meta[name = "csrf-token"]').each ->
      console.log @
      json['auth_token'] = @.content

    console.log json

    user = new Metrics.Models.User(json)


    @siteLayout = new Metrics.Views.SiteLayout(model: user)
    siteNavbar = new Metrics.Views.SiteNavbar(model: user)
    siteShirts = new Metrics.Views.SiteShirts()
    siteFooter = new Metrics.Views.SiteFooter(model: user)
    siteHome = new Metrics.Views.SiteHome(model: user)

    console.log @auth_token
    console.log "display"

    $('#user-data').html(@siteLayout.render().el)

    @siteLayout.siteNavbar.show siteNavbar

    @siteLayout.siteHome.show siteHome

    @siteLayout.siteFooter.show siteFooter

    @getClients()
    $ ->
      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs a:first').tab('show')

      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs li:eq(1) a').tab('show')

      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs li:eq(2) a').tab('show')

      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs li:eq(3) a').tab('show')

      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs a:last').tab('show')

      $('#theTabs a').click (e) ->
        e.preventDefault()
        $('#theTabs a:last').tab('show')


  signOutPressed: ->
    json_empty = {id: null, email: null, created_at: null, updated_at: null, name: null}
    user = new Metrics.Models.User(json_empty)
    @siteLayout = new Metrics.Views.SiteLayout(model: user)
    siteNavbar = new Metrics.Views.SiteNavbar(model: user)
    siteFooter = new Metrics.Views.SiteFooter(model: user)
    siteHome = new Metrics.Views.SiteHome(model: user)

    console.log @auth_token
    console.log "display"

    $('#user-data').html(@siteLayout.render().el)

    @siteLayout.siteNavbar.show siteNavbar

    @siteLayout.siteHome.show siteHome

    @siteLayout.siteFooter.show siteFooter

    # siteLayout.siteForm.hide siteForm


  reports: (user) -> 
    @user_reports = new Metrics.Views.Reports(model: user)
    @siteLayout.siteHome.hide 
    @siteLayout.siteHome.show @user_reports   

  editPressed: (user) ->
    @siteForm = new Metrics.Views.EditAccount(model: user)
    @siteLayout.siteForm.show @siteForm
    $(document).ready ->
      $('#editAccount').modal 'show'
      $('#editAccount').on 'shown', ->
        $("#user_password").focus()

  loginPressed: (user) ->
    @siteForm = new Metrics.Views.Login(model: user)
    @siteLayout.siteForm.show @siteForm
    
    $(document).ready ->
      $('#myModal').modal 'show'
      $('#myModal').on 'shown', ->
        $("#user_password").focus()

  signupPressed: (user) ->
    @siteForm = new Metrics.Views.SignUp(model: user)
    @siteLayout.siteForm.show @siteForm
    $(document).ready ->
      $('#mySignupModel').modal 'show'
      $('#mySignupModel').on 'shown', ->
        $("#user_password").focus()

  routes:
    '/users/:': 'show',


  getClients: ->
    that = @
    $.ajax
      url: '/clients.json'
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


