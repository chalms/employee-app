


#global TaskApp 
"use strict"
TaskApp.module "Layout", (Layout, App, Backbone) ->
  
  # Layout Header View
  # ------------------
  Layout.Header = Backbone.Marionette.ItemView.extend(
    template: "#template-header"
    
    # UI bindings create cached attributes that
    # point to jQuery selected objects
    ui:
      input: "#new-task"

    events:
      "keypress #new-task": "onInputKeypress"

    onInputKeypress: (e) ->
      ENTER_KEY = 13
      taskText = @ui.input.val().trim()
      if e.which is ENTER_KEY and taskText
        @collection.create title: taskText
        @ui.input.val ""
      return
  )
  
  # Layout Footer View
  # ------------------
  Layout.Footer = Backbone.Marionette.ItemView.extend(
    template: "#template-footer"
    
    # UI bindings create cached attributes that
    # point to jQuery selected objects
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
      @listenTo App.vent, "taskList:filter", @updateFilterSelection, this
      return

    serializeData: ->
      active = @collection.getActive().length
      total = @collection.length
      activeCount: active
      totalCount: total
      completedCount: total - active

    onRender: ->
      @$el.parent().toggle @collection.length > 0
      @updateFilterSelection()
      return

    updateFilterSelection: ->
      @ui.filters.removeClass("selected").filter("[href=\"" + (location.hash or "#") + "\"]").addClass "selected"
      return

    onClearClick: ->
      completed = @collection.getCompleted()
      completed.forEach (task) ->
        task.destroy()
        return

      return
  )
  return