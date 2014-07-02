class Metrics.Views.TasksLayout extends Marionette.Layout
	template: JST['templates/tasks/task_template']
  regions: {
    header: "#task_header",
    main: "#task_list",
    footer: "#task_footer"
  }

  initialize: (model) -> 
    console.log "creating tasks layout"
    console.log model

  # Start the app by showing the appropriate views
  # and fetching the list of task items, if there are any
  render: -> 
    console.log "redering task list"
    if (@started == false) then start() 

  url: ->
    "api/tasks"

  start: ->
    console.log starting
    @started = true 
    @.header.show(Metrics.Routers.appRouter.__proto__.showHeader(@taskList))
    @.footer.show(Metrics.Routers.appRouter.__proto__.showFooter(@taskList))
    @.main.show(Metrics.Routers.appRouter.__proto__.showTaskList(@taskList))
    @taskList.fetch()
    return
  
  # Set the filter to show complete or all items
  filterItems: (filter) ->
    @.vent.trigger "taskList:filter", (filter and filter.trim()) or ""
    return
