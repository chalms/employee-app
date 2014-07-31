class Metrics.Models.App extends Backbone.Marionette.Model
  defaults: {
    'data': ""
  }

  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults.key)