class EmployeeApp.MainController extends EmployeeApp.ApplicationController
  routingKey: 'main'

  index: (params) ->
    @set 'firstName', 'Bruce'
    @set 'lastName', 'Wayne'

  @accessor 'fullName', ->
    "#{@get('firstName')} #{@get('lastName')}"
