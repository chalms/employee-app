class EmployeeApp.PartsEditView extends Batman.View
  viewDidAppear: ->
    # Your node is in the DOM and ready to accept instructions (aka jQuery)

  buttonWasClicked: (node, event, view) ->
  	# view.lookupKeypath
    # You can put all of your event handlers in this view file. You can access
    # data by using `view.lookupKeypath('someData')` or `@controller`.
