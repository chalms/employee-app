class Metrics.Views.SiteNavbar extends Marionette.ItemView
  template: JST['templates/site/site_navbar']
  tagName: "li"
  className: "dropdown"
  events:
    "click #login" : "login"
    "click #signup" : "signup"
    "click #edit-account" : "editAccount"
    "click #logout" : "logout"
    "click #reports" : "reports"

  reports: -> 
    Metrics.Routers.appRouter.reports(@model)

  signup: ->
    Metrics.Routers.appRouter.signupPressed(@model)

  login: ->
    Metrics.Routers.appRouter.loginPressed(@model)

  editAccount: ->
    Metrics.Routers.appRouter.editPressed(@model)

  logout: ->
    @model = null
    Metrics.Routers.appRouter.editPressed(@model)
    console.log "called"
