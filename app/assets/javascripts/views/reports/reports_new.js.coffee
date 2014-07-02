class Metrics.Views.NewReport extends Marionette.Layout
  template: JST['templates/reports/new']
  regions: {
    taskApp: "#t",
    reportClient: "#client" 
  }

  initialize: -> 
    @task_app = Metrics.Routers.appRouter.__proto__.taskApp(@.model)
    @client = Metrics.Routers.appRouter.__proto__.reportClient(@.model)

  render: -> 
    if (@task_app != undefined)
      $("#t").html(@task_app.render().el)
    else 
      console.log "task app is undefined"
    if (@client != undefined)
      $("#client").html(@client.render().el)
    else 
      @.show
