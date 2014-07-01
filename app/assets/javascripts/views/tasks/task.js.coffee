class Metrics.Views.Task extends Marionette.ItemView

  tagName: "li"
  template: JST["task-item-view"] #'assets/templates/tasks/task-template.html'
  
  ui:
    edit: ".edit"

  events:
    "click .destroy": "destroy"
    "dblclick label": "onEditClick"
    "keydown .edit": "onEditKeypress"
    "focusout .edit": "onEditFocusout"
    "click .toggle": "toggle"

  modelEvents:
    change: "render"

  onRender: ->
    @$el.removeClass "active completed"
    if @model.get("completed")
      @$el.addClass "completed"
    else
      @$el.addClass "active"
    return

  destroy: ->
    @model.destroy()
    return

  toggle: ->
    @model.toggle().save()
    return

  onEditClick: ->
    @$el.addClass "editing"
    @ui.edit.focus()
    @ui.edit.val @ui.edit.val()
    return

  onEditFocusout: ->
    taskText = @ui.edit.val().trim()
    if taskText
      @model.set("title", taskText).save()
      @$el.removeClass "editing"
    else
      @destroy()
    return

  onEditKeypress: (e) ->
    ENTER_KEY = 13
    ESC_KEY = 27
    if e.which is ENTER_KEY
      @onEditFocusout()
      return
    if e.which is ESC_KEY
      @ui.edit.val @model.get("title")
      @$el.removeClass "editing"
    return