class Metrics.Collections.Messages extends Backbone.Collection
  url: '/users_messages'
  model: Metrics.Models.Message

  initialize: (args) ->
    super(args)
    console.log("created")
