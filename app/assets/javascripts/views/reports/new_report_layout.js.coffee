class Metrics.Views.NewReportLayout extends Marionette.Layout
  template: JST['templates/reports/new']
  regions: {
    task_app: "#t"
    # client: "#client" 
  }

  # initialize: ->
  #   @.task_app.show Metrics.Routers.appRouter.__proto__.tasks_layout(@.model)
  #   # @client = Metrics.Routers.appRouter.__proto__.reportClient(@.model)


  serializeData: -> 
    console.log "serialized"