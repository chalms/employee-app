Metrics.Models.User = App.ApiModel.extend
  resourceKey: -> 'user'

  initialize: ->
    console.log @
    @url = Metrics.Models.User.apiPath
    console.log @url

  set_data: (h) =>
  	console.log h
    # console.log h
,
  apiPath: '/users'
  hash: ''


