var App = Backbone.Router.extend({

  routes: {
    "api/:users/:auth_token":         "home",
    "api/:users/:auth_token/*path":     "home",
    "api/:reports":       "reports",
    "api/:reports/:id":  "report",
    "api/:tasks/:id": "tasks", 
    "api/:tasks": "tasks"
  },

  help: function() {
    ...
  },

  search: function(query, page) {
    ...
  }

});
routes: {

}

Backbone.history.start({pushState: true}); 

// - content_for :javascripts do
//   = javascript_include_tag "templates/your_template"