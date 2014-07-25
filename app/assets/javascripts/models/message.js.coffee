class Metrics.Models.Message extends Backbone.Model
  defaults: {
    'data': ""
  }

  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults.key)

