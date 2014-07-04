Metrics.Collections.Reports = App.ApiCollection.extend
  model: Metrics.Models.Report
  getCompleted: ->
    @filter @_isCompleted

  getActive: ->
    @reject @_isCompleted

  comparator: "created"
  
  _isCompleted: (task) ->
    task.isCompleted()