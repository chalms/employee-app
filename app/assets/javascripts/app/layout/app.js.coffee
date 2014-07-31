class App.Layout extends Backbone.Marionette.Layout

  region: {
    'navbar' : @navbar,
    'sub_nav':  @sub_nav,
    'sidebar' : @sidebar,
    'sub_view': @sub_view
  },

  initialize: -> 
    
