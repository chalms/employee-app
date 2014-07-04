class Metrics.Views.Tasks extends Marionette.CompositeView
  template: JST["templates/tasks/task_composite_view"]
  itemViewContainer: "#task-list"
  itemView: Metrics.Views.Task
  
  ui:
    toggle: "#toggle-all"

  events:
    "click #toggle-all": "onToggleAllClick"

  collectionEvents:
    all: "update"
 
  printError: (e) -> 
    console.log e
    console.log @

  length: -> 
    t = null 
    try 
      t = @collection.length 
    catch e 
      @printError e 
    if t is null then t = @.model.length 
    return t 

    
  initialize: -> 
    console.log @
    console.log @length() 
    

  onRender: ->
    console.log "calling onRender in tasks"
    @update()
    return

  serializeData: -> 
    console.log "serialized"

  update: ->
    reduceCompleted = (left, right) ->
      left and right.get("completed")
    allCompleted = @collection.reduce(reduceCompleted, true)
    @ui.toggle.prop "checked", allCompleted
    @$el.parent().toggle !! @collection.length
    return

  onToggleAllClick: (e) ->
    isChecked = e.currentTarget.checked
    @collection.each (task) ->
      task.save completed: isChecked
      return
    return