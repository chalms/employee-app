Metrics.Models.Report = App.ApiModel.extend
  resourceKey: -> 'report'

  initialize: (model) ->
    console.log "report model"
    console.log model
    @url = Metrics.Models.Report.apiPath
    defaults:
      description: ""
      name: ""
      report_date: Date.today()
      

  set_data: (h) =>
    # console.log h

,
  apiPath: '/report'

