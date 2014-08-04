class Web.Collections.Subnav extends Backbone.Collection
  url: '/links'
  models: Web.Models.Link

  initialize: (args) ->
    super(args)
    for arg in args
      @.add(new Web.Models.Link(model: arg))
