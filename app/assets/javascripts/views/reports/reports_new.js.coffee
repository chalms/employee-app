class Metrics.Views.NewReport extends Marionette.Layout
  template: JST['templates/reports/new']
  regions: {
    taskApp: "#taskApp",
    reportClient: "#reportClient" 
  }

  initialize: -> 
    t = @.model 
    @task_app = Metrics.Routers.appRouter.__proto__.taskApp(t)
    @client = Metrics.Routers.appRouter.__proto__.reportClient(t)

  render: -> 
    if (@task_app != undefined)
      $("#taskApp").html(@task_app.render().el)
    else 
      console.log "task app is undefined"
    if (@client != undefined)
      $("#reportClient").html(@client.render().el)
    else 
      @.show
