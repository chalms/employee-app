class Web.Routers.App extends Backbone.Marionette.Router

  routes: {
    '/' : @home,
    '/logins': @index
  },

  initialize: ->
    index();

  home: ->
    # new Web.Layout.Home

  index: ->
    new Web.Layout.App({model: new Web.Models.App})
