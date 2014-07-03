class Metrics.Views.Tasks extends Marionette.CompositeView
  template: JST["templates/tasks/task_composite_view"]
  childViewContainer: "#task-list"
  childView: Metrics.Views.Task
  
  ui:
    toggle: "#toggle-all"

  events:
    "click #toggle-all": "onToggleAllClick"

  collectionEvents:
    all: "update"

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
    @$el.parent().toggle !!@collection.length
    return

  onToggleAllClick: (e) ->
    isChecked = e.currentTarget.checked
    @collection.each (task) ->
      task.save completed: isChecked
      return

    return