class Metrics.Views.TasksFooter extends Marionette.ItemView
  template: JST["templates/tasks/task_footer"]
    
    # UI bindings create cached attributes that
    # point to jQuery selected objects

  activeCount: 1

  ui:
    filters: "#filters a"
    completed: ".completed a"
    active: ".active a"
    all: ".all a"
    summary: "#task-count"

  events:
    "click #clear-completed": "onClearClick"

  collectionEvents:
    all: "render"

  templateHelpers:
    activeCountLabel: ->
      ((if @activeCount is 1 then "item" else "items")) + " left"

  initialize: ->
    # @listenTo App.vent, "taskList:filter", @updateFilterSelection, this
    # return
    console.log @
    console.log "@colleciton"
    console.log @.model
    return 

  serializeData: ->
    # active = @collection.getActive().length
    # total = @collection.length
    activeCount: 1
    totalCount: 2
    completedCount: 1

  onRender: ->
    console.log "calling onRender"
    @$el.parent().toggle @.model.length > 0
    @updateFilterSelection()
    return

  updateFilterSelection: ->
    @ui.filters.removeClass("selected").filter("[href=\"" + (location.hash or "#") + "\"]").addClass "selected"
    return

  onClearClick: ->
    completed = 0
    completed.forEach (task) ->
      task.destroy()
      return

    return