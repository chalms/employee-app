Metrics.Models.Task = App.ApiModel.extend
  resourceKey: -> 'task'

  initialize: ->
    @url = Metrics.Models.Task.apiPath    

    defaults:
      description: ""
      completed: false
      created: 0
      parts: []

    initialize: ->
      @set "created", Date.now()  if @isNew()
      return

    toggle: ->
      @set "completed", not @isCompleted()

    isCompleted: ->
      @get "completed"