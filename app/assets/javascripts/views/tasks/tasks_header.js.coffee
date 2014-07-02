class Metrics.Views.TasksHeader extends Marionette.ItemView
  template: JST["templates/tasks/task_header"]
  
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