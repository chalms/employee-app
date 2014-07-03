Metrics.Collections.Tasks = App.ApiCollection.extend
  model: Metrics.Models.Task

  url: 'api/tasks'

  getCompleted: ->
    # @filter @_isCompleted
    return 0 

  getActive: ->
    @reject @_isCompleted
    return 0 

  comparator: "created"