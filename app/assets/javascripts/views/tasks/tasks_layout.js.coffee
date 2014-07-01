class Metrics.Views.TasksLayout extends Marionette.Layout
	template: JST['templates/tasks_layout']

  regions: {
	  header: '#taskapp',
	  main: '#main',
	  footer: '#footer'
  }
  
  # Start the app by showing the appropriate views
  # and fetching the list of task items, if there are any
  url: ->
    "api/tasks"

  start: ->
    @showHeader @taskList
    @showFooter @taskList
    @showTaskList @taskList
    @taskList.fetch()
    return

  showHeader: (taskList) ->
    header = new App.Layout.Header(collection: taskList)
    App.header.show header
    return

  showFooter: (taskList) ->
    footer = new App.Layout.Footer(collection: taskList)
    App.footer.show footer
    return

  showTaskList: (taskList) ->
    App.main.show new TaskList.Views.ListView(collection: taskList)
    return

  
  # Set the filter to show complete or all items
  filterItems: (filter) ->
    App.vent.trigger "taskList:filter", (filter and filter.trim()) or ""
    return
