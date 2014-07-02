class Metrics.Views.NewReport extends Marionette.Layout
  template: JST['templates/reports/new']
  regions: {
    t: "#t",
    client: "#client" 
  }

  initialize: (model) -> 
    console.log "@.model"
    console.log @.model 

    @task_app = Metrics.Routers.appRouter.__proto__.taskApp(@.model.user)
    @client = Metrics.Routers.appRouter.__proto__.reportClient(@.model)

  render: -> 
    if (@task_app != undefined)
      console.log @task_app
      $("#t").html(@task_app.render().el)
    else 
      console.log "task app is undefined"
    if (@client != undefined)
      $("#reportClient").html(@client.render().el)
    else 
      @.show
