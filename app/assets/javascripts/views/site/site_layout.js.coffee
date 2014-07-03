class Metrics.Views.SiteLayout extends Marionette.Layout
  template: JST['templates/site/site_layout']

  regions: {
    siteNavbar: "#site-navbar",
    siteHome: "#site-home",
    siteFooter: "#site-footer"
  }  

  # initialize: -> 
  #   if (@.model.attributes["reports"].length > 0) 
  #     @siteHome = Metrics.Routers.appRouter.__proto__.reports(@.model)
  #   else 
  #     @siteHome = Metrics.Routers.appRouter.__proto__.new_report(@.model)

  showHome: ->
    $('#site-home').html(@siteHome.render().el)
    
