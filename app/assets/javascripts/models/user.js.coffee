Metrics.Models.User = App.ApiModel.extend
  resourceKey: -> 'user'

  initialize: ->
    @url = Metrics.Models.User.apiPath

  set_data: (h) =>
    # console.log h

,
  apiPath: '/users'
  hash: ''


