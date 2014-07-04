Metrics.Models.Report = App.ApiModel.extend
  resourceKey: -> 'report'

  initialize: ->

    @url = Metrics.Models.Report.apiPath
    
    defaults:
      description: ""
      name: ""
      report_date: Date.now()
      tasks: []
      

  set_data: (h) =>
    
,
  apiPath: '/report'

