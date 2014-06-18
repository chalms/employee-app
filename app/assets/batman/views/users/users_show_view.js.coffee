class EmployeeApp.UsersShowView extends Batman.View
  viewDidAppear: ->
    # Your node is in the DOM and ready to accept instructions (aka jQuery)

  buttonWasClicked: (node, event, view) ->
  	console.log node 
  	console.log event 
  	console.log view 
    # You can put all of your event handlers in this view file. You can access
    # data by using `view.lookupKeypath('someData')` or `@controller`.
