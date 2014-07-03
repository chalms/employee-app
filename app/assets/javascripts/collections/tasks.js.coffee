Metrics.Collections.Tasks = App.ApiCollection.extend
  model: Metrics.Models.Task

  getCompleted: ->
    @filter @_isCompleted

  getActive: ->
    @reject @_isCompleted

  comparator: "created"