Metrics.Models.Report = App.ApiModel.extend
  resourceKey: -> 'report'

  initialize: (model) ->
    @user = model.user 
    @url = Metrics.Models.Report.apiPath
    
    defaults:
      description: ""
      name: ""
      report_date: Date.now()
      user_id: @user.id
      tasks: []
      

  set_data: (h) =>
    # console.log h

,
  apiPath: '/report'

