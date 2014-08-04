class Web.Models.Navbar extends Backbone.Marionette.Model

  defaults: {
    'logout': '/logout'
  }

  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults[key]())


