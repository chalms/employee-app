class Web.Models.Sidebar extends Backbone.Marionette.Model
  defaults: {

  }
  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults[key]())


