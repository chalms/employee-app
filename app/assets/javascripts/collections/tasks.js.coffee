Metrics.Collections.Tasks = App.ApiCollection.extend
  model: Metrics.Models.Task

  getCompleted: ->
    return @filter @_isCompleted

  getActive: ->
    return @reject @_isCompleted

  comparator: "created"