Metrics.Collections.Tasks = App.ApiCollection.extend
  model: Metrics.Tasks.Task
  getCompleted: ->
    @filter @_isCompleted

  getActive: ->
    @reject @_isCompleted

  comparator: "created"
  
  _isCompleted: (task) ->
    task.isCompleted()