class Metrics.Views.Tasks extends Marionette.ItemView
  template: JST["templates/tasks/task-composite-view"]
  itemView: Metrics.Views.Task
  itemViewContainer: "#task-list"
  ui:
    toggle: "#toggle-all"

  events:
    "click #toggle-all": "onToggleAllClick"

  collectionEvents:
    all: "update"

  onRender: ->
    @update()
    return

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