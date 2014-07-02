class Metrics.Views.TasksLayout extends Marionette.Layout
	template: JST['templates/tasks/task_template']
  regions: {
    header: '#task_header',
	  main: '#task_list',
	  footer: '#task_footer'
  }
  
  # Start the app by showing the appropriate views
  # and fetching the list of task items, if there are any
  render: -> 
    console.log "redering task list"

  url: ->
    "api/tasks"

  start: ->
    @showHeader @taskList
    @showFooter @taskList
    @showTaskList @taskList
    @taskList.fetch()
    return

  showHeader: (taskList) ->
    header = new Metrics.Views.TasksHeader(collection: taskList)
    @.header.show header
    return

  showFooter: (taskList) ->
    footer = new Metrics.Views.TasksFooter(collection: taskList)
    @.footer.show footer
    return

  showTaskList: (taskList) ->
    @.main.show new Metrics.Views.Tasks(collection: taskList)
    return

  
  # Set the filter to show complete or all items
  filterItems: (filter) ->
    @.vent.trigger "taskList:filter", (filter and filter.trim()) or ""
    return
