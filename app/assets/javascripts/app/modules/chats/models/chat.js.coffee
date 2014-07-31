class Metrics.Models.Chat extends Backbone.Model
  defaults: {
    'name': "",
    'unread_count': 0
  }

  initialize: ->
    @setDefaults();

  setDefaults: ->
    for key in @defaults
      if (@.get(key) is null)
        @.set(key, @defaults.key)



