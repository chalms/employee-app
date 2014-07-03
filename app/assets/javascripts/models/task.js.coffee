Metrics.Models.Task = App.ApiModel.extend
  resourceKey: -> 'task'

  initialize: ->
    console.log "trying to create a task model"

    @url = Metrics.Models.Task.apiPath    

    defaults:
      description: ""
      completed: false
      created: 0
      report_id: null

    @set "created", Date.now()  if @isNew()
    return

  toggle: ->
    @set "completed", not @isCompleted()

  isCompleted: ->
    @get "completed"

  set_data: (h) =>
   console.log "set_data: (h)"
   console.log h

, 
  apiPath: '/task'