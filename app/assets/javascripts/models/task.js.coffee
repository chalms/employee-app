Metrics.Models.Task = App.ApiModel.extend
  resourceKey: -> 'task'

  defaults:
    description: ""
    completed: false
    created: 0
    report_id: null

  initialize: ->
    console.log "trying to create a task model"

    @url = Metrics.Models.Task.apiPath    

    @set "created", Date.now()  if @isNew()
    @set_data(@defaults) 
    return

  toggle: ->
    @set "completed", not @isCompleted()

  isCompleted: ->
    @get "completed"

  set_data: (h) ->
    console.log @ 
    @set(h)

   
, 
  apiPath: '/api/tasks'
  attributes: {description: null, completed: false}