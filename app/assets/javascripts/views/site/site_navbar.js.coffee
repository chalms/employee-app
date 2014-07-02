class Metrics.Views.SiteNavbar extends Marionette.ItemView
  template: JST['templates/site/site_navbar']
  tagName: "li"
  className: "dropdown"
  
  events: 
    "click #new_report" : "new_report"
    "click #reports" : "reports"
    "click #employees" : "employees"

  new_report: -> 
    Metrics.Routers.appRouter.newReport(@model)

  reports: ->
    Metrics.Routers.appRouter.reports(@model)

  employees: ->
    Metrics.Routers.appRouter.employees(@model)
