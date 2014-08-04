class Web.Collections.Projects extends Backbone.Collection
  url: '/projects'
  models: Web.Models.Project

  initialize: (args) ->
    super(args)