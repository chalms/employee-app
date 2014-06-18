class EmployeeApp.UsersController extends EmployeeApp.ApplicationController
  routingKey: 'users'

  index: (params) ->
  	
    # @set('users', EmployeeApp.User.get('all'))

  @accessor 'fullName', ->
    "#{@get('firstName')} #{@get('lastName')}"

  show: (params) ->
  	# EmployeeApp.User.get('params.id'), @errorHandler (user) =>
    	# @set('user', user)

  edit: (params) ->

  new: (params) ->

  create: (params) ->

  update: (params) ->

  destroy: (params) ->

